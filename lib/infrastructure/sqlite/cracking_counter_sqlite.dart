import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';
import 'package:cracking_counter/infrastructure/sqlite/db_helper.dart';
import 'package:uuid/uuid.dart';

class CrackingCounterSqlite implements ICrackingCounterRepository {
  @override
  Future<List<CrackingCounterEntity>> getAll(String userId) async {
    final List<Map<String, dynamic>> result = await DbHelper.db!.query('cracking_count_view', where: 'user_id = ?', whereArgs: [userId]);
    return List.generate(result.length, (i) {
      return CrackingCounterEntity(result[i]['user_id'],result[i]['body_part_id'],result[i]['body_part_name'],result[i]['total_count'],result[i]['today_count'],result[i]['ancestor_body_part_id']);
    });
  }

  @override
  Future<void> register(String userId, String bodyPartId) async {
    var uuid = const Uuid();
    Map<String, String> map = {
      'id' : uuid.v4(),
      'user_id' : userId,
      'body_part_id' : bodyPartId,
      'count' : "1",
      'register_date' : DateTime.now().toString()
    };
    await DbHelper.db!.insert('cracking_history', map);
  }
  
}