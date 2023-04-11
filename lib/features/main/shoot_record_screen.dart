import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/db.dart';
// MVVM 방식으로 분류할 필요성이 있음
class NumberPad extends StatefulWidget {
  @override
  NumberPadState createState() => NumberPadState();
}

Future<void> _saveData(int total, int count, double average) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('total', total);
  await prefs.setInt('count', count);
  await prefs.setDouble('average', average);
}

class NumberPadState extends State<NumberPad> {
  int _total = 0;
  int _count = 0;
  double _average = 0.0;

  final List<int> _numbers = [];

  void _removeLastNumber() {
    if (_numbers.isNotEmpty) {
      final lastNumber = _numbers.removeLast();
      if (_count > 0) {
        _count--;
        if (_total >= lastNumber) {
          _total -= lastNumber;
        }
      }
      _average = _count == 0 ? 0 : _total / _count;
      setState(() {});
    }
  }

  void _addToTotal(int number) {
    setState(() {
      _numbers.add(number);
      _total += number;
      _count++;
      _average = _total / _count;
    });
  }

  Future<void> _saveData(int total, int count, double average) async {
    final dbHelper = DbHelper();
    await dbHelper.saveResult(total, count, average);
  }

  Widget _buildNumberButton(int number) {
    return GestureDetector(
      onTap: () => _addToTotal(number),
      onLongPress: () {
        if (_count > 0) {
          setState(() {
            _total -= number;
            _count--;
            _average = _count > 0 ? _total / _count : 0.0;
          });
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Target Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total: $_total',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Count: $_count',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Average: ${_average.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildNumberButton(1),
                _buildNumberButton(2),
                _buildNumberButton(3),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildNumberButton(4),
                _buildNumberButton(5),
                _buildNumberButton(6),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildNumberButton(7),
                _buildNumberButton(8),
                _buildNumberButton(9),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildNumberButton(10),
                ElevatedButton(
                  onPressed: _removeLastNumber, // changed to cancel last number
                  child: const Text('cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _saveData(_total, _count, _average);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Target Manager'),
                          content: Text(
                            '평균 점수: ${_average.toStringAsFixed(2)}\n슈팅 횟수: $_count,\n최종 점수: $_total',
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                  animationDuration:
                                      Duration(milliseconds: 300)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('result'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
