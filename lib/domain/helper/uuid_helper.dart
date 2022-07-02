import 'package:uuid/uuid.dart';

class UuidHelper {
  static String newUuid() {
    Uuid _uuid = Uuid();
    return _uuid.v4();
  }

  static bool isUuid(String value) {
    try {
      Uuid.parse(value);
    }
    catch (e) {
      return false;
    }
    return true;
  }
}