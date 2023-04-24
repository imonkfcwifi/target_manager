import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:target_manager/constants/gaps.dart';

import '../db/db.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: FutureBuilder<List<Record>>(
        future: DbHelper().getResult(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final records = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            'Total: ${record.total}, Count: ${record.count}, Average: ${record.average.toStringAsFixed(2)}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
