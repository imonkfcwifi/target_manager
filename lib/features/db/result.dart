import 'package:flutter/material.dart';
import 'package:target_manager/features/db/db.dart';

class ResultScreen extends StatelessWidget {
  final int total;
  final int count;
  final double average;

  const ResultScreen(
      {Key? key,
      required this.total,
      required this.count,
      required this.average})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total: $total',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Count: $count',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Average: ${average.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Save the result to the database.
                final MyDatabase database = MyDatabase();
                database.insertScore(
                    Score(total: total, count: count, average: average));
                // Navigate to the result list screen.
                Navigator.pushNamedAndRemoveUntil(
                    context, '/result_list', (route) => false);
              },
              child: const Text('Save Result'),
            ),
          ],
        ),
      ),
    );
  }
}
