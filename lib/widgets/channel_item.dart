import 'package:document_manager/models/channel.dart';
import 'package:document_manager/widgets/circle_icon_image.dart';
import 'package:flutter/material.dart';

class ChannelItem extends StatelessWidget {
  const ChannelItem({
    Key? key,
    required this.channel,
    required this.onTap,
  }) : super(key: key);

  final Channel channel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Row(
          children: [
            CircleIconImage(
              imageUrl: channel.iconImageUrl,
              errorImagePath: 'assets/images/default_school.png',
              diameter: 48.0,
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(channel.name),
                Text(
                  channel.description,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
