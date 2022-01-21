import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/chat_view.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/explore_view.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/group_view.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/track_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavBody extends StatefulWidget {
  const NavBody({Key? key}) : super(key: key);

  @override
  _NavBodyState createState() => _NavBodyState();
}

class _NavBodyState extends State<NavBody> {
  final List<Widget> _children = [
    ExploreView(),
    ChatView(),
    TrackView(),
    GroupView()
  ];
  final List<PersistentBottomNavBarItem> _navBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.explore_outlined),
      title: 'Explore',
      inactiveColorPrimary: Colors.black,
      activeColorPrimary: blue,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.chat_bubble_outline),
      title: 'Chat',
      inactiveColorPrimary: Colors.black,
      activeColorPrimary: blue,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.track_changes_outlined),
      title: 'Track',
      inactiveColorPrimary: Colors.black,
      activeColorPrimary: blue,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.groups_outlined),
      title: 'Group',
      inactiveColorPrimary: Colors.black,
      activeColorPrimary: blue,
    ),
  ];

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _children,
      items: _navBarItems,
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10),
          colorBehindNavBar: Colors.black),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style2,
    );
  }
}
