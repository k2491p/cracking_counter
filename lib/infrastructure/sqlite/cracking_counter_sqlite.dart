import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/entity/cracking_history_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';
import 'package:cracking_counter/domain/value_object/body_part_id.dart';
import 'package:cracking_counter/infrastructure/sqlite/db_helper.dart';
import 'package:uuid/uuid.dart';

class CrackingCounterSqlite implements ICrackingCounterRepository {
  @override
  Future<List<CrackingCounterEntity>> getAll(String userId) async {
    final List<Map<String, dynamic>> result = await DbHelper.db!.query('cracking_count_view', where: 'user_id = ?', whereArgs: [userId]);
    return List.generate(result.length, (i) {
      var bodyPartId = BodyPartId(result[i]['body_part_id']);
      var ancestorId = BodyPartId(result[i]['ancestor_body_part_id']);
      return CrackingCounterEntity(result[i]['user_id'],bodyPartId,result[i]['body_part_name'],result[i]['total_count'],result[i]['today_count'],ancestorId);
    });
  }

  @override
  Future<void> register(CrackingHistoryEntity entity) async {
    await DbHelper.db!.insert('cracking_history', entity.map);
  }
  
}