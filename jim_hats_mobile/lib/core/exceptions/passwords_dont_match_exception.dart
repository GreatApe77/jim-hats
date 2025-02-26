import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class PasswordsDontMatchException extends ApplicationException {
  PasswordsDontMatchException() : super(message: 'Passwords dont match');
}
