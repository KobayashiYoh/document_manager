import 'dart:io';

import 'package:document_manager/constants/styles.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/chat_room_state.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/pages/chat_room_page/check_status_user_view.dart';
import 'package:document_manager/pages/chat_room_page/post_item.dart';
import 'package:document_manager/providers/chat_room_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/providers/users_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/widgets/post_search_bar.dart';
import 'package:document_manager/widgets/scrollable_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  const ChatRoomPage({super.key, required this.channel});

  final Channel channel;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final double _inputFieldHeight = 88.0;
  final double _imagePreviewHeight = 64.0;

  bool get disableSendButton {
    final image = ref.read(chatRoomProvider).image;
    return _messageController.text.isEmpty && image == null;
  }

  void _onSubmittedSearchField(String value) {
    ref.read(chatRoomProvider.notifier).setSearchWord(value);
  }

  void _onPressedClear() {
    ref.read(chatRoomProvider.notifier).setSearchWord('');
    _searchTextController.clear();
  }

  void _resetSearchWord() {
    final notifier = ref.read(chatRoomProvider.notifier);
    _searchTextController.clear();
    notifier.setSearchWord('');
    _onSubmittedSearchField('');
    _scrollMax();
  }

  Future<void> _onPressedSendButton() async {
    if (disableSendButton) {
      return;
    }
    final notifier = ref.read(chatRoomProvider.notifier);
    await notifier.sendPost(
      channelId: widget.channel.id,
      message: _messageController.text,
    );
    _messageController.clear();
  }

  void _onLongPressCheck(List<String> readUserIds) {
    final sameSchoolUsers = ref.read(usersProvider);
    showScrollableModalBottomSheet(
      context: context,
      headerText: '確認状況',
      child: CheckStatusUserView(
        sameSchoolUsers: sameSchoolUsers,
        channelUserIds: widget.channel.userIds,
        readUserIds: readUserIds,
      ),
    );
  }

  void _scrollMax() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(microseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetSearchWord();
      _scrollMax();
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
    final state = ref.watch(chatRoomProvider);
    final notifier = ref.read(chatRoomProvider.notifier);
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
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    controller: _scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<Post> posts = snapshot.data!.docs
                          .map((doc) => Post.fromJson(doc.data()))
                          .toList();
                      final post = posts[index];
                      final user = users.firstWhere(
                        (user) => user.id == post.userId,
                      );
                      if (state.isNotMachPost(post, user)) {
                        return const SizedBox.shrink();
                      }
                      final bool isLastIndex = index == posts.length - 1;
                      final bool isFirstIndex = index == 0;
                      final double firstMarginTop = 32.0 +
                          (state.showSearchBar ? PostSearchBar.height : 0);
                      return PostItem(
                        post: post,
                        user: user,
                        signedInUserId: signedInUser!.id,
                        margin: EdgeInsets.only(
                          top: isFirstIndex ? firstMarginTop : 0,
                          bottom: isLastIndex ? 120.0 : 32.0,
                        ),
                        onPressedCheck: () => notifier.onPressedCheck(
                          post: post,
                          signedInUserId: signedInUser.id,
                        ),
                        onLongPressCheck: () =>
                            _onLongPressCheck(post.readUserIds),
                      );
                    },
                  );
                },
              ),
              Column(
                children: [
                  if (state.showSearchBar)
                    PostSearchBar(
                      searchTextController: _searchTextController,
                      onSubmitted: _onSubmittedSearchField,
                      onPressedClear: _onPressedClear,
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
                                  onPressed: notifier.onPressedCamera,
                                  icon: const Icon(Icons.camera_alt_outlined),
                                ),
                                IconButton(
                                  onPressed: notifier.onPressedImageGallery,
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
      ),
    );
  }
}
