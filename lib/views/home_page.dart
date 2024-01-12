import 'package:document_manager/debug/debug_page.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/views/chat_page.dart';
import 'package:document_manager/widgets/channel_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kExampleSchool.name),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      return ChannelItem(
                        channel: channels[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatPage(channel: channels[index]),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DebugPage(),
            ),
          );
        },
        child: const Icon(Icons.developer_mode),
      ),
    );
  }
}
