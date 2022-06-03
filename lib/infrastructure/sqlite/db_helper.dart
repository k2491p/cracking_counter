import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

const _dbFile = 'cracking_counter.db';
const _dbVersion = 1;

class DbHelper {
  static Database? db;
  late Transaction? _txn;

  static Future<Database?> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbFile);
    var uuid = const Uuid();

    db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE user (
            id TEXT NOT NULL,
            name TEXT,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          INSERT INTO "user" (id, name) VALUES('${uuid.v4().toString()}', '');
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
          INSERT INTO body_part (id, name) VALUES('a50a395b-fdf4-e5ae-9751-2866a0c087cf', '首');
          INSERT INTO body_part (id, name) VALUES('56ce60f3-a267-cd00-de00-5a69d3c37900', '背中');
          INSERT INTO body_part (id, name) VALUES('0e4f2659-724e-c93f-d709-ef4bee18ceb3', '腰');
          INSERT INTO body_part (id, name) VALUES('9e593b71-ec5e-89f0-4b82-4b08871ac9f4', '右手');
          INSERT INTO body_part (id, name) VALUES('b6075b51-7b8f-9b21-2056-e8938b481b80', '左手');
          INSERT INTO body_part (id, name) VALUES('a2cc7c56-c5b9-4280-640f-7fc4b7e7bb02', '右足');
          INSERT INTO body_part (id, name) VALUES('2a12d9d5-2970-72fa-3bb5-087d64432ad0', '左足');
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
          CREATE VIEW cracking_count_view AS
            SELECT
            u.id as user_id,
            bp.id as body_part_id,
            ifnull(s2.today_count,
            0) as today_count,
            ifnull(s1.total_count,
            0) as total_count
          FROM
            "user" u
          LEFT JOIN
              body_part bp 
            ON
            1 = 1
          LEFT JOIN
              (
            SELECT
              user_id,
              body_part_id,
              ifnull(sum(count),
              0) AS total_count
            FROM
              cracking_history
            GROUP BY
              user_id,
              body_part_id
              ) s1
              ON
            u.id = s1.user_id
            AND bp.id = s1.body_part_id
          LEFT JOIN 
              (
            SELECT
              user_id,
              body_part_id,
              ifnull(sum(count),
              0) AS today_count
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
            AND s1.body_part_id = s2.body_part_id;
        ''');

        await db.execute('''
          CREATE VIEW cracking_list_view AS 
            SELECT
              ccv.user_id,
              ccv.body_part_id,
              bp.name as body_part_name,
              ifnull(ccv.today_count, 0) as today_count,
              ifnull(ccv.total_count, 0) as total_count
            FROM
              body_part bp
            LEFT JOIN cracking_count_view ccv ON
              bp.id = ccv.body_part_id;
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