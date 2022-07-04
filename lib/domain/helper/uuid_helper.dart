import 'package:uuid/uuid.dart';

class UuidHelper {
  static String newUuid() {
    Uuid _uuid = Uuid();
    return _uuid.v4();
  }

  static bool isUuid(String value) {
    try {
      if (Uuid.isValidUUID(fromString: value)) return true;
    }
    catch (e) {
      return false;
    }
    return false;
  }
}