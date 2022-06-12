import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';
import 'package:cracking_counter/infrastructure/sqlite/db_helper.dart';

class CrackingCounterSqlite implements ICrackingCounterRepository {
  @override
  Future<List<CrackingCounterEntity>> getAll(String userId) async {
    final List<Map<String, dynamic>> result = await DbHelper.db!.query('cracking_count_view', where: 'user_id = ?', whereArgs: [userId]);
    return List.generate(result.length, (i) {
      return CrackingCounterEntity(result[i]['user_id'],result[i]['body_part_id'],result[i]['body_part_name'],result[i]['total_count'],result[i]['today_count'],result[i]['ancestor_body_part_id']);
    });
  }
  
}