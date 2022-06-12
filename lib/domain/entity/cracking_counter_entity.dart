import 'package:uuid/uuid.dart';

import '../value_object/count.dart';

class CrackingCounterEntity {
  String userId;
  String bodyPartId;
  String parentId;
  String bodyPartName;
  late Count totalCount;
  late Count todayCount;
  CrackingCounterEntity(
      this.userId, this.bodyPartId, this.bodyPartName, int totalCount, int todayCount, this.parentId) {
    this.totalCount = Count(totalCount);
    this.todayCount = Count(todayCount);
  }
}
