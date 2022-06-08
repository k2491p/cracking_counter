import 'package:cracking_counter/domain/value_object/value_object_base.dart';

class Count extends ValueObjectBase<Count> {
  int _value;
  Count(this._value);
  int get value => _value;
  String get stringValue => _value.toString();
  @override
  bool equalsCore(Count other) {
    return this.value == other.value;
  }

}
