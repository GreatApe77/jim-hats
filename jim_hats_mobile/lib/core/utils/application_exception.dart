abstract class ApplicationException implements Exception {
  final String _message;

  ApplicationException({String message = 'Application exception'})
      : _message = message;

  @override
  String toString() {
    return 'ApplicationException: $runtimeType';
  }

  String getMessage() {
    return _message;
  }
}
