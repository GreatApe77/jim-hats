import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class WrongPasswordException extends ApplicationException {
  WrongPasswordException() : super(message: 'Wrong password');
}
