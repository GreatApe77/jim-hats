abstract class Validatable<T> {
  /// Validates the given value.
  /// Returns null if the value is valid, otherwise returns an error message.
  String? validate(T? value);
}
