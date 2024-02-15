import 'package:document_manager/debug/debug_page.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/pages/chat_room_page/chat_room_page.dart';
import 'package:document_manager/pages/sign_in_page/sign_in_page.dart';
import 'package:document_manager/providers/chat_notifier.dart';
import 'package:document_manager/providers/sign_in_notifier.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/widgets/channel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<ChatPage> {
  Future<void> _onPressedSignOut() async {
    final notifier = ref.read(signInProvider.notifier);
    await notifier.signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignInPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatProvider);
    final String schoolName = ref.watch(signedInSchoolProvider)?.name ?? '';
    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolName),
        actions: [
          IconButton(
            onPressed: _onPressedSignOut,
            icon: const Icon(Icons.logout),
          ),
        ],
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
                                  ChatRoomPage(channel: channels[index]),
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
