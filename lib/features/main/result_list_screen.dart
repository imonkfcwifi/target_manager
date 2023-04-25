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
        title: const Text(
          '슈팅기록',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                      final record = records.reversed.toList()[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            '최종점수: ${record.total}, 슈팅횟수: ${record.count}, 평균: ${record.average.toStringAsFixed(2)}',
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
