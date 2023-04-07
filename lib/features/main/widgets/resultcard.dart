import 'package:flutter/material.dart';

import '../../db/db.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    Key? key,
    required this.result,
    required this.onDelete,
  }) : super(key: key);

  final Result result;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    print('ResultCard: $result'); // debug print
    return Card(
      child: Column(
        children: [
          Text('Total: ${result.total}'),
          Text('Count: ${result.count}'),
          Text('Average: ${result.average}'),
          ElevatedButton(
            onPressed: onDelete,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
