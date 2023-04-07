class Result {
  int id;
  String date;
  int total;
  int count;
  double average;

  Result({
    required this.id,
    required this.date,
    required this.total,
    required this.count,
    required this.average,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'total': total,
      'count': count,
      'average': average,
    };
  }

  static Result fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'],
      date: map['date'],
      total: map['total'],
      count: map['count'],
      average: map['average'],
    );
  }
}
