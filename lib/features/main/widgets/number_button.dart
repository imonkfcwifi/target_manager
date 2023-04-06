import 'package:flutter/material.dart';

class Numberpad extends StatefulWidget {
  @override
  _NumberpadState createState() => _NumberpadState();
}

class _NumberpadState extends State<Numberpad> {
  int _total = 0;
  int _count = 0;
  double _average = 0.0;
  final List<int> _numbers = [];

  void _addToTotal(int number) {
    setState(() {
      _numbers.add(number);
      _total += number;
      _count++;
      _average = _total / _count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: const Center(
          child: Text(
            '',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
