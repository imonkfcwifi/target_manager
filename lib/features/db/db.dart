import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  static const _keyTotal = 'total';
  static const _keyCount = 'count';
  static const _keyAverage = 'average';

  Future<void> saveResult(int total, int count, double average) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTotal, total);
    await prefs.setInt(_keyCount, count);
    await prefs.setDouble(_keyAverage, average);
  }

  Future<Result> getResult() async {
    final prefs = await SharedPreferences.getInstance();
    final total = prefs.getInt(_keyTotal) ?? 0;
    final count = prefs.getInt(_keyCount) ?? 0;
    final average = prefs.getDouble(_keyAverage) ?? 0.0;
    return Result(total, count, average);
  }

  Future<void> deleteResult() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyTotal);
    await prefs.remove(_keyCount);
    await prefs.remove(_keyAverage);
  }
}

class Result {
  final int total;
  final int count;
  final double average;

  Result(this.total, this.count, this.average);

  Result.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        count = json['count'],
        average = json['average'];

  Map<String, dynamic> toJson() => {
        'total': total,
        'count': count,
        'average': average,
      };
}
