import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class InvalidTokenException extends ApplicationException {
  InvalidTokenException() : super(message: 'The Auth token is invalid');
}
