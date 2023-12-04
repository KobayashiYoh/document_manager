import 'package:document_manager/models/channel.dart';
import 'package:flutter/material.dart';

class DebugChannelItem extends StatelessWidget {
  const DebugChannelItem({Key? key, required this.channel}) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Text(
          'ID: ${channel.id}, name: ${channel.name}, description: ${channel.description}'),
    );
  }
}
