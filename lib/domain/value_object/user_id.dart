import 'package:cracking_counter/domain/helper/uuid_helper.dart';
import 'package:cracking_counter/domain/value_object/value_object_base.dart';
import 'package:uuid/uuid.dart';

class UserId extends ValueObjectBase<UserId> {
  late String _value;
  UserId(String value) {
    if (value == "") {
      _value = "";
      return;
    }
    if (!UuidHelper.isUuid(value)) throw Exception();
    _value = value;
  }
  String get value => _value;
  @override
  bool equalsCore(UserId other) {
    return value == other.value;
  }

}
