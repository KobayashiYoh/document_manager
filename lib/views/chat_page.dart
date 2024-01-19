import 'dart:io';

import 'package:document_manager/constants/app_colors.dart';
import 'package:document_manager/constants/styles.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/providers/chat_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/providers/users_notifier.dart';
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
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final double _inputFieldHeight = 88.0;
  final double _searchBarHeight = 80.0;
  final double _imagePreviewHeight = 64.0;

  bool get disableSendButton {
    final image = ref.read(chatProvider).image;
    return _messageController.text.isEmpty && image == null;
  }

  void _onSubmittedSearchField(String value) {
    final notifier = ref.read(chatProvider.notifier);
    notifier.setSearchWord(value);
  }

  void _resetSearchWord() {
    final notifier = ref.read(chatProvider.notifier);
    _searchTextController.clear();
    notifier.setSearchWord('');
    _onSubmittedSearchField('');
    _scrollMax();
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

  void _scrollMax() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    Future.value(() {
      _resetSearchWord();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatProvider);
    final notifier = ref.read(chatProvider.notifier);
    final signedInUser = ref.watch(signedInUserProvider);
    final users = ref.watch(usersProvider);
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(widget.channel.name),
          actions: [
            IconButton(
              onPressed: () {
                notifier.setShowSearchBar(!state.showSearchBar);
              },
              icon: Icon(state.showSearchBar
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_left),
            ),
          ],
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
                      final bool isNotMachSearchWord =
                          state.searchWord.isNotEmpty &&
                              !posts[index].message.contains(state.searchWord);
                      if (isNotMachSearchWord) {
                        return const SizedBox.shrink();
                      }
                      return PostItem(
                        post: posts[index],
                        user: users.firstWhere(
                          (user) => user.id == posts[index].userId,
                        ),
                        isMyPost: signedInUser!.id == posts[index].userId,
                        margin: index == 0
                            ? EdgeInsets.only(
                                top: state.showSearchBar
                                    ? _searchBarHeight + 16.0
                                    : 16.0)
                            : index == posts.length - 1
                                ? EdgeInsets.only(
                                    bottom:
                                        _inputFieldHeight + _imagePreviewHeight)
                                : EdgeInsets.zero,
                        initialize: () async {},
                      );
                    },
                  );
                },
              ),
              Column(
                children: [
                  if (state.showSearchBar)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: _searchBarHeight,
                      color: AppColors.main,
                      child: TextField(
                        controller: _searchTextController,
                        onSubmitted: _onSubmittedSearchField,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 8.0),
                          prefixIcon: IconButton(
                            onPressed: () => _onSubmittedSearchField,
                            icon: const Icon(Icons.search),
                          ),
                          suffix: IconButton(
                            onPressed: () {
                              notifier.setSearchWord('');
                              _searchTextController.clear();
                            },
                            icon: const Icon(Icons.close),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: Styles.chatOutlineInputBorder,
                          focusedBorder: Styles.chatOutlineInputBorder,
                        ),
                      ),
                    ),
                  const Spacer(),
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
                                      focusedBorder:
                                          Styles.chatOutlineInputBorder,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final notifier = ref.read(chatProvider.notifier);
            final signedInUser = ref.watch(signedInUserProvider);
            final post = Post(
              id: 'c68b763a-6d5f-4e36-9e2c-4af3baefc8df',
              schoolId: signedInUser!.schoolId,
              channelId: widget.channel.id,
              userId: signedInUser.id,
              createdAt: DateTime.now(),
              message: 'よろしく',
              imageUrl: '',
              readUserIds: [],
            );
            await notifier.addPostReadId(
              post: post,
              signedInUserId: signedInUser.id,
            );
          },
          child: const Icon(Icons.remove_red_eye),
        ),
      ),
    );
  }
}
