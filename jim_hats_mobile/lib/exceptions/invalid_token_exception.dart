import 'package:jim_hats_mobile/shared/utils/application_exception.dart';

class InvalidTokenException extends ApplicationException {
  InvalidTokenException() : super(message: 'The Auth token is invalid');
}
