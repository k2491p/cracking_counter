import 'package:cracking_counter/domain/helper/uuid_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

    db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        var userId = UuidHelper.newUuid();
        const storage = FlutterSecureStorage();
        await storage.write(key: 'userId', value: userId);
        var rightHand = '9e593b71-ec5e-89f0-4b82-4b08871ac9f4';
        var rightThumb = 'fb5726dd-1b36-0ad8-04ad-887df360867f';
        var rightIndex = '4f149f46-ec36-3689-0e52-44189ce5e61a';
        var rightMiddle = '3e872f29-9e4e-19fb-f36d-96edb3767e60';
        var rightRing = 'f0738bf5-48b7-1573-e21d-44dd30b30b11';
        var rightLittle = '9cb4eb1e-9ec1-b1ac-ce43-3ae15c8b68e2';
        var leftHand = 'b6075b51-7b8f-9b21-2056-e8938b481b80';
        var leftThumb = '01a345a2-25e7-a09c-2bd0-04a3b691be7c';
        var leftIndex = 'ed9f5bc8-7d62-2a63-0469-66cfd40aa2a1';
        var leftMiddle = '0f90a92b-75b2-e438-5a68-cc15a24f6767';
        var leftRing = '18704685-c9a9-fb2e-c475-56bf8b4f5cc6';
        var leftLittle = '06f4dc50-22e5-48be-efd5-61371d1aee49';

        await db.execute('''
          CREATE TABLE user (
            id TEXT NOT NULL,
            name TEXT,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          INSERT INTO "user" (id, name) VALUES('$userId', '');
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
            display_order INTEGER NOT NULL,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('a50a395b-fdf4-e5ae-9751-2866a0c087cf', '首', 10);
        ''');


        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('56ce60f3-a267-cd00-de00-5a69d3c37900', '背中', 20);
        ''');


        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('0e4f2659-724e-c93f-d709-ef4bee18ceb3', '腰', 30);
        ''');


        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$rightHand', '右手', 40);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$rightThumb', '親指', 41);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$rightIndex', '人差指', 42);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$rightMiddle', '中指', 43);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$rightRing', '薬指', 44);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$rightLittle', '小指', 45);
        ''');


        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$leftHand', '左手', 50);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$leftThumb', '親指', 51);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$leftIndex', '人差指', 52);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$leftMiddle', '中指', 53);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$leftRing', '薬指', 54);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('$leftLittle', '小指', 55);
        ''');

        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('a2cc7c56-c5b9-4280-640f-7fc4b7e7bb02', '右足', 60);
        ''');


        await db.execute('''
          INSERT INTO body_part (id, name, display_order) VALUES('2a12d9d5-2970-72fa-3bb5-087d64432ad0', '左足', 70);
        ''');

        await db.execute('''
          CREATE TABLE body_part_tree (
            id TEXT NOT NULL,
            ancestor_body_part_id TEXT NOT NULL,
            descendent_body_part_id TEXT NOT NULL,
            PRIMARY KEY (id),
            FOREIGN KEY (ancestor_body_part_id) REFERENCES body_part(id),
            FOREIGN KEY (descendent_body_part_id) REFERENCES body_part(id)
          )
        ''');

        await db.execute('''
          INSERT INTO body_part_tree (id, ancestor_body_part_id, descendent_body_part_id) 
          VALUES ('${UuidHelper.newUuid()}', '$rightHand', '$rightThumb'), ('${UuidHelper.newUuid()}', '$rightHand', '$rightIndex'), ('${UuidHelper.newUuid()}', '$rightHand', '$rightMiddle'), ('${UuidHelper.newUuid()}', '$rightHand', '$rightRing'), ('${UuidHelper.newUuid()}', '$rightHand', '$rightLittle'),
          ('${UuidHelper.newUuid()}', '$leftHand', '$leftThumb'), ('${UuidHelper.newUuid()}', '$leftHand', '$leftIndex'), ('${UuidHelper.newUuid()}', '$leftHand', '$leftMiddle'), ('${UuidHelper.newUuid()}', '$leftHand', '$leftRing'), ('${UuidHelper.newUuid()}', '$leftHand', '$leftLittle');
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
            bpt.ancestor_body_part_id,
            bp.name as body_part_name,
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
          	body_part_tree bpt
          	ON bpt.descendent_body_part_id = bp.id 
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
            AND s1.body_part_id = s2.body_part_id
            order by bp.display_order;
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