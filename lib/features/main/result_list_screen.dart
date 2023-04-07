import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/db.dart';

class ResultListScreen extends StatelessWidget {
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
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return ListTile(
                  title: Text(
                    'Total: ${record.total}, Count: ${record.count}, Average: ${record.average.toStringAsFixed(2)}, ${DateFormat("yyyy년 MM월 dd일").format(DateTime.now())}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await DbHelper().deleteRecord(record.id ?? 0);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Record deleted')),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
