import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:uuid/uuid.dart';

class Data {
  static List<CrackingCounterEntity> GetCrackingCounterList(String userId) {
    var uuid = const Uuid();
    var lightHand = uuid.v4();
    var entity1 = CrackingCounterEntity(userId, uuid.v4(), '首', 10, 1, null);
    var entity2 = CrackingCounterEntity(userId, uuid.v4(), '腰', 15, 2, null);
    var entity3 = CrackingCounterEntity(userId, lightHand, '右手', 15, 2, null);
    var entity4 = CrackingCounterEntity(userId, uuid.v4(), '親指', 15, 2, lightHand);
    var entity5 = CrackingCounterEntity(userId, uuid.v4(), '人差指', 15, 2, lightHand);
    var entity6 = CrackingCounterEntity(userId, uuid.v4(), '中指', 15, 2, lightHand);
    var entity7 = CrackingCounterEntity(userId, uuid.v4(), '薬指', 15, 2, lightHand);
    var entity8 = CrackingCounterEntity(userId, uuid.v4(), '小指', 15, 2, lightHand);
    return [entity1, entity2, entity3, entity4, entity5, entity6, entity7, entity8];
  }
}