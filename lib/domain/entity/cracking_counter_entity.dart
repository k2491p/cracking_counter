import 'package:uuid/uuid.dart';

import '../value_object/count.dart';

class CrackingCounterEntity {
  String id;
  String userId;
  String bodyPartId;
  late Count totalCount;
  late Count todayCount;
  CrackingCounterEntity(
      this.id, this.userId, this.bodyPartId, int totalCount, int todayCount) {
    this.totalCount = Count(totalCount);
    this.todayCount = Count(todayCount);
  }
}
