import 'dart:async';

import 'package:document_manager/debug/debug_channel_item.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:flutter/material.dart';

class DebugChannelsPage extends StatefulWidget {
  const DebugChannelsPage({Key? key}) : super(key: key);

  @override
  State<DebugChannelsPage> createState() => _DebugChannelsPageState();
}

class _DebugChannelsPageState extends State<DebugChannelsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _setChannels() async {
    try {
      await FirestoreRepository.setChannel(
        name: _nameController.text,
        description: _descriptionController.text,
        userIds: kExampleChannel.userIds,
      );
    } catch (e) {
      rethrow;
    }
    _nameController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DebugChannelsPage'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              StreamBuilder(
                stream: FirestoreRepository.channelSnapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<Channel> channels = snapshot.data!.docs
                          .map((doc) => Channel.fromJson(doc.data()))
                          .toList();
                      return DebugChannelItem(channel: channels[index]);
                    },
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 80.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: 160.0,
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          label: Text('name'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          label: Text('description'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _setChannels(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
