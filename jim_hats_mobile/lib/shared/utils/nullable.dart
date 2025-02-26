class Nullable<T> {
  final T? _value;

  const Nullable(this._value);

  T? get value => _value;
}