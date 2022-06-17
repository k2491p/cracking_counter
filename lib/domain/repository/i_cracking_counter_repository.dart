import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';

abstract class ICrackingCounterRepository {
  Future<List<CrackingCounterEntity>> getAll(String userId);
  void register(String userId, String bodyPartId);
}
