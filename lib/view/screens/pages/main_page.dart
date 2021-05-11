import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int selectedPage = 0;

  List<Widget> pages = [
    Home(),
    Container(color: Colors.yellow),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: buildHomeBar(),
    );
  }

  BottomNavigationBar buildHomeBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      currentIndex: selectedPage,
      onTap: onItemSelected,
      items: [
        BottomNavigationBarItem(
          label: "Feed",
          icon: Icon(CupertinoIcons.chevron_left_slash_chevron_right),
        ),
        BottomNavigationBarItem(
          label: "Me",
          icon: Icon(CupertinoIcons.person),
        )
      ],
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.7),
    );
  }

  void onItemSelected(int index) {
    setState(() => selectedPage = index);
  }
}
