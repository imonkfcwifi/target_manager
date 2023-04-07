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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await DbHelper().deleteResult();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All records deleted')),
                    );
                  },
                  child: const Text('Delete All Records'),
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
