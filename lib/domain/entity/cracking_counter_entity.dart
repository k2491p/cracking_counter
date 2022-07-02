import 'package:cracking_counter/domain/value_object/body_part_id.dart';
import 'package:uuid/uuid.dart';

import '../value_object/count.dart';

class CrackingCounterEntity {
  String userId;
  BodyPartId bodyPartId;
  BodyPartId? parentId;
  String bodyPartName;
  late Count totalCount;
  late Count todayCount;
  List<CrackingCounterEntity> children = [];

  CrackingCounterEntity(
      this.userId, this.bodyPartId, this.bodyPartName, int totalCount, int todayCount, this.parentId) {
    this.totalCount = Count(totalCount);
    this.todayCount = Count(todayCount);
  }
}
