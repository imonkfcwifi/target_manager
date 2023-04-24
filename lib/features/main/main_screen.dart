import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:target_manager/features/main/result_list_screen.dart';
import 'package:target_manager/features/main/setting_screen.dart';
import 'package:target_manager/features/main/shoot_record_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    NumberPad(),
    ResultListScreen(),
    InfoBox(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.ads_click),
            label: '슈팅하기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '슈팅기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_sharp),
            label: '튜토리얼',
          ),
        ],
      ),
    );
  }
}
