import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite {
  Future<Database> getConnection() async {
    return await openDatabase(join(await getDatabasesPath(), 'app.db'),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute('''
    create table task(
      id integer primary key AUTOINCREMENT,
      title TEXT not null unique,
      isDone INTEGER default 0 check(isDone == 0 or isDone == 1)
    );
    ''');

    await db.execute('CREATE unique index task_title ON task(title);');
  }
}
