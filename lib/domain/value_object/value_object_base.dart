abstract class ValueObjectBase<T extends ValueObjectBase<T>> {
  @override
  bool equals(Object obj) {
    var vo = obj as T;
    if (vo == null) return false;
    return equalsCore(vo);
  }

  @override
  bool operator ==(Object obj) => equals(obj);

  @override
  int get hashCode => runtimeType.hashCode;

  bool equalsCore(T other);
}
