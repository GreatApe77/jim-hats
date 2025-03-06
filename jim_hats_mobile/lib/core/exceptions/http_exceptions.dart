class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() => 'HttpException: $message';
}

class BadRequestException extends HttpException {
  BadRequestException(super.message);
}

class UnauthorizedException extends HttpException {
  UnauthorizedException(super.message);
}

class NotFoundException extends HttpException {
  NotFoundException(super.message);
}

class ServerException extends HttpException {
  ServerException(super.message);
}

class NetworkException extends HttpException {
  NetworkException(super.message);
}
