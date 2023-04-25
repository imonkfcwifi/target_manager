import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_manager/constants/gaps.dart';
import 'package:target_manager/constants/sizes.dart';

import '../db/db.dart';

// MVVM 방식으로 분류할 필요성이 있음
class NumberPad extends StatefulWidget {
  const NumberPad({super.key});

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
  bool selected = false;
  int _lastNumber = 0;
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
      _lastNumber = number;
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
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
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
        title: const Text(
          '타겟 매니저 Beta 1.0 🪒',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Gaps.v32,
                  Text(
                    '합계: $_total',
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '슈팅 횟수: $_count',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '평균 값: ${_average.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '최근 값: $_lastNumber',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Gaps.v32,
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
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(Sizes.size24),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed:
                            _removeLastNumber, // changed to cancel last number
                        child: const Text('점수 취소'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(Sizes.size24),
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        onPressed: () async {
                          await _saveData(_total, _count, _average);
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('타겟 매니저'),
                                content: Text(
                                  '수고하셨습니다.\n최종 점수: $_total\n슈팅 횟수: $_count\n평균 점수: ${_average.toStringAsFixed(2)}',
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('데이터 저장'),
                                  ),
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                        animationDuration:
                                            Duration(milliseconds: 300)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('닫기'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('저장하기'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
