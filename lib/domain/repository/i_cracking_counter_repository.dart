import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/entity/cracking_history_entity.dart';

abstract class ICrackingCounterRepository {
  Future<List<CrackingCounterEntity>> getAll(String userId);
  void register(CrackingHistoryEntity crackingHistoryMap);
}
