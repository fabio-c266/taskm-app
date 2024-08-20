class Task {
  final int _id;
  final String _title;
  bool _isDone;

  Task({
    required int id,
    required String title,
    required bool isDone,
  })  : _id = id,
        _title = title,
        _isDone = isDone;

  int get id => _id;
  String get title => _title;
  bool get isDone => _isDone;

  void toggleIsDone() {
    _isDone = !_isDone;
  }
}
