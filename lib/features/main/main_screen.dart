import 'package:flutter/material.dart';
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
    const ResultListScreen(),
    const SettingsScreen()
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
            icon: Icon(Icons.keyboard),
            label: 'Number Pad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Shoot Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
