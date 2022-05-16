import 'package:cracking_counter/domain/value_object/value_object_base.dart';

class Count extends ValueObjectBase<Count> {
  int value;
  Count(this.value);

  @override
  bool equalsCore(Count other) {
    return this.value == other.value;
  }
}
