import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/helper/uuid_helper.dart';
import 'package:cracking_counter/domain/value_object/body_part_id.dart';
import 'package:uuid/uuid.dart';

class CrackingHistoryEntity {
  Map<String, String> map = {};

  CrackingHistoryEntity(BodyPartId bodyPartId) {

      map = {
        'id' : UuidHelper.newUuid(),
        'user_id' : Shared.userId,
        'body_part_id' : bodyPartId.value!,
        'count' : "1",
        'register_date' : DateTime.now().toString()
      };
  }
}