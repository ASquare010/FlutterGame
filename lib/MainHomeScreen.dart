import 'package:flutter/material.dart';
import 'package:flutter_app/ModelClass/MyBottomNavigationbar.dart';
import 'package:flutter_app/ModelClass/ThemeClass.dart';

import 'Screen/PageOne.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        extendBody: true,
        bottomNavigationBar: BottomNavyBar(
          curve: Curves.easeInQuart,
          showElevation: true,
          items: _itemList(),
          selectedIndex: _currentIndex,
          onItemSelected: (_index) {
            setState(() {
              _currentIndex = _index;
            });
          },
          itemCornerRadius: 8,
        ),
        body: _returnPage(_currentIndex),
      ),
    );
  }

  List<BottomNavyBarItem> _itemList() {
    return [
      BottomNavyBarItem(
          icon: Icon(Icons.home_outlined), title: Text("Home"), activeColor: VeryLightBlue, inactiveColor: grey),
      BottomNavyBarItem(
          icon: Icon(Icons.apps), title: Text("All Games"), activeColor: VeryLightBlue, inactiveColor: grey),
      BottomNavyBarItem(
          icon: Icon(Icons.person_outline), title: Text("Profile"), activeColor: VeryLightBlue, inactiveColor: grey),
    ];
  }

  Widget _returnPage(int index) {
    if (index == 0) {
      return PageOne();
    } else if (index == 1) {
      return PageOne();
    } else if (index == 2) {
      return PageOne();
    } else
      return Container(
        child: Center(child: Text("SomeThing went wrong")),
      );
  }
}
