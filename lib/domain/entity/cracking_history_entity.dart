import 'package:cracking_counter/application/shared.dart';
import 'package:uuid/uuid.dart';

class CrackingHistoryEntity {
  Map<String, String> map = {};

  CrackingHistoryEntity(String bodyPartId) {

      var uuid = const Uuid();
      map = {
        'id' : uuid.v4(),
        'user_id' : Shared.userId,
        'body_part_id' : bodyPartId,
        'count' : "1",
        'register_date' : DateTime.now().toString()
      };
  }
}