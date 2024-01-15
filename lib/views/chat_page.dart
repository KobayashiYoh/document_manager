import 'dart:io';

import 'package:document_manager/constants/styles.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/providers/chat_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.channel});

  final Channel channel;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final double _inputFieldHeight = 88.0;
  final double _imagePreviewHeight = 64.0;

  bool get disableSendButton {
    final image = ref.read(chatProvider).image;
    return _messageController.text.isEmpty && image == null;
  }

  Future<void> _onPressedSendButton() async {
    if (disableSendButton) {
      return;
    }
    final notifier = ref.read(chatProvider.notifier);
    await notifier.sendPost(
      channelId: widget.channel.id,
      message: _messageController.text,
    );
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatProvider);
    final notifier = ref.read(chatProvider.notifier);
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(widget.channel.name),
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              StreamBuilder(
                stream: FirestoreRepository.postSnapshots(
                  channelId: widget.channel.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(microseconds: 1),
                      curve: Curves.easeInOut,
                    );
                  });

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    controller: _scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<Post> posts = snapshot.data!.docs
                          .map((doc) => Post.fromJson(doc.data()))
                          .toList();
                      return PostItem(
                        post: posts[index],
                        user: kExampleStudent,
                        isMyPost: true,
                        margin: index == 0
                            ? const EdgeInsets.only(top: 16.0)
                            : index == posts.length - 1
                                ? EdgeInsets.only(
                                    bottom:
                                        _inputFieldHeight + _imagePreviewHeight)
                                : EdgeInsets.zero,
                      );
                    },
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                height: state.image == null
                    ? _inputFieldHeight
                    : _inputFieldHeight + _imagePreviewHeight,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () async {
                                // TODO: カメラから画像を選択する。
                              },
                              icon: const Icon(Icons.camera_alt_outlined),
                            ),
                            IconButton(
                              onPressed: notifier.onPressedImageButton,
                              icon: const Icon(Icons.photo_outlined),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: TextFormField(
                                controller: _messageController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'メッセージ',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: Styles.chatOutlineInputBorder,
                                  focusedBorder: Styles.chatOutlineInputBorder,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            IconButton(
                              onPressed: _onPressedSendButton,
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                        if (state.image != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: SizedBox(
                              height: _imagePreviewHeight,
                              child: Image.file(
                                File(state.image!.path),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
