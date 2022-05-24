import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _dbFile = 'cracking_counter.db';
const _dbVersion = 1;

class DbHelper {
  late Database? _db;
  late Transaction? _txn;

  Future<Database?> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbFile);

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE user (
            id TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE user_settings (
            id TEXT NOT NULL,
            user_id TEXT NOT NULL,
            body_part_id TEXT NOT NULL,
            display INTEGER NOT NULL,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE cracking_history (
            id TEXT NOT NULL,
            user_id TEXT NOT NULL,
            body_part_id TEXT NOT NULL,
            count INTEGER NOT NULL,
            register_date TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE body_part (
            id TEXT NOT NULL,
            name TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE body_part_tree (
            id TEXT NOT NULL,
            ancestor_body_part_id TEXT NOT NULL,
            descendent_body_part_id TEXT NOT NULL,
            name TEXT NOT NULL,
            PRIMARY KEY (id),
            FOREIGN KEY (ancestor_body_part_id) REFERENCES body_part(id),
            FOREIGN KEY (descendent_body_part_id) REFERENCES body_part(id),
          )
        ''');

        await db.execute('''
          CREATE TABLE cracking_history (
            id TEXT NOT NULL,
            user_id TEXT NOT NULL,
            body_part_id TEXT NOT NULL,
            count INTEGER NOT NULL,
            register_date TEXT NOT NULL,
            PRIMARY KEY (id),
            FOREIGN KEY (user_id) REFERENCES user(id),
            FOREIGN KEY (body_part_id) REFERENCES body_part(id),
          )
        ''');
      },
    );

    return _db;
  }

  Future<void> dispose() async {
    await _db?.close();
    _db = null;
  }

  Future<T> transaction<T>(Future<T> Function() f) async {
    return _db!.transaction<T>((txn) async {
      _txn = txn;
      return await f();
    }).then((v) {
      _txn = null;
      return v;
    });
  }

  Future<List<Map<String, dynamic>>> rawQuery(
      String sql, [
        List<dynamic>? arguments,
      ]) async {
    return await (_txn ?? _db)!.rawQuery(sql, arguments);
  }

  Future<int> rawInsert(
      String sql, [
        List<dynamic>? arguments,
      ]) async {
    return await (_txn ?? _db)!.rawInsert(sql, arguments);
  }

  Future<int> rawDelete(
      String sql, [
        List<dynamic>? arguments,
      ]) async {
    return await (_txn ?? _db)!.rawDelete(sql, arguments);
  }
}