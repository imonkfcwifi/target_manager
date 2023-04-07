import 'package:flutter/material.dart';

import '../db/db.dart';
import 'widgets/resultcard.dart';

class ResultListScreen extends StatefulWidget {
  const ResultListScreen({Key? key}) : super(key: key);

  @override
  _ResultListScreenState createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
  List<Result> _results = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dbHelper = DbHelper();
    final results = await dbHelper.getResults();
    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: _results.isEmpty
          ? const Center(
              child: Text('No Results'),
            )
          : ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final result = _results[index];
                return ResultCard(
                  result: result,
                  onDelete: () async {
                    final dbHelper = DbHelper();
                    await dbHelper.deleteResult(result);
                    setState(() {
                      _results.remove(result);
                    });
                  },
                );
              },
            ),
    );
  }
}
