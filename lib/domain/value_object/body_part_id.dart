import 'package:cracking_counter/domain/helper/uuid_helper.dart';
import 'package:cracking_counter/domain/value_object/value_object_base.dart';
import 'package:uuid/uuid.dart';

class BodyPartId extends ValueObjectBase<BodyPartId> {
  late String? _value;
  BodyPartId(String? value) {
    if (value == null || value == "") {
      _value = null;
      return;
    }
      if (!UuidHelper.isUuid(value)) {
        throw Exception();
      }
      _value = value;
    }

  String? get value => _value;

  @override
  bool equalsCore(BodyPartId other) {
    return value == other.value;
  }

}
