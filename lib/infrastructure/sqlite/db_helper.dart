import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _dbFile = 'cracking_counter.db';
const _dbVersion = 1;

class DbHelper {
  static Database? db;
  late Transaction? _txn;

  static Future<Database?> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbFile);

    db = await openDatabase(
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
            FOREIGN KEY (descendent_body_part_id) REFERENCES body_part(id)
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
            FOREIGN KEY (body_part_id) REFERENCES body_part(id)
          )
        ''');

        await db.execute('''
          CREATE VIEW cracking_view AS
            SELECT
              s1.user_id,
              s1.body_part_id,
              s2.today_count,
              s1.total_count
            FROM
              (
                SELECT
                  user_id,
                  body_part_id,
                  sum(count) AS total_count
                FROM
                  cracking_history
                GROUP BY
                  user_id,
                  body_part_id
              ) s1
            LEFT JOIN 
              (
                SELECT
                  user_id,
                  body_part_id,
                  sum(count) AS today_count
                FROM
                  cracking_history
                WHERE
                  date(register_date) = date(CURRENT_TIMESTAMP)
                GROUP BY
                  user_id,
                  body_part_id
              ) s2
            ON 
              s1.user_id = s2.user_id
              AND s1.body_part_id = s2.body_part_id
        ''');
      },
    );

    return db;
  }

  Future<void> dispose() async {
    await db?.close();
    db = null;
  }

  Future<T> transaction<T>(Future<T> Function() f) async {
    return db!.transaction<T>((txn) async {
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
    return await (_txn ?? db)!.rawQuery(sql, arguments);
  }

  Future<int> rawInsert(
      String sql, [
        List<dynamic>? arguments,
      ]) async {
    return await (_txn ?? db)!.rawInsert(sql, arguments);
  }

  Future<int> rawDelete(
      String sql, [
        List<dynamic>? arguments,
      ]) async {
    return await (_txn ?? db)!.rawDelete(sql, arguments);
  }
}