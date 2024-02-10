import 'package:document_manager/constants/app_colors.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/pages/admin_page/admin_page.dart';
import 'package:document_manager/pages/chat_page.dart';
import 'package:document_manager/pages/document_page.dart';
import 'package:document_manager/pages/home_page.dart';
import 'package:document_manager/pages/loading_view.dart';
import 'package:document_manager/pages/my_page.dart';
import 'package:document_manager/providers/bottom_navigation_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends ConsumerState<BottomNavigation> {
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChatPage(),
    DocumentPage(),
    MyPage(),
    AdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bottomNavigationProvider);
    final notifier = ref.read(bottomNavigationProvider.notifier);
    final signInUser = ref.watch(signedInUserProvider);
    return Scaffold(
      body: state.isLoading
          ? const LoadingView()
          : Center(
              child: _widgetOptions.elementAt(state.selectedIndex),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'ホーム',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'チャット',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc),
            label: 'プリント',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'マイページ',
          ),
          if (signInUser != null && signInUser.isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings_outlined),
              label: '管理者',
            ),
        ],
        currentIndex: state.selectedIndex,
        elevation: 8.0,
        selectedItemColor: AppColors.main,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: notifier.onItemTapped,
      ),
    );
  }
}
