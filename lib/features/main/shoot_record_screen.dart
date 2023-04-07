import 'package:flutter/material.dart';

class NumberPad extends StatefulWidget {
  @override
  _NumberPadState createState() => _NumberPadState();
}

class _NumberPadState extends State<NumberPad> {
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

  void _reset() {
    setState(() {
      _total = 0;
      _count = 0;
      _average = 0.0;
    });
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
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Target Manager'),
                          content: Text(
                              '평균 점수: ${_average.toStringAsFixed(2)}\n슈팅 횟수: $_count,\n최종 점수: $_total'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('계속 기록하기'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _total = 0;
                                  _count = 0;
                                  _average = 0.0;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('점수 초기화'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('점수 확인'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
