import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final int total;
  final int count;
  final double average;
  final Function(DateTime date, int total, int count, double average) onSave;

  const SaveButton({
    required this.total,
    required this.count,
    required this.average,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        DateTime now = DateTime.now();
        onSave(now, total, count, average);
      },
      child: const Text('Save'),
    );
  }
}
