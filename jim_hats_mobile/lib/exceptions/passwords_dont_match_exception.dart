import 'package:jim_hats_mobile/shared/utils/application_exception.dart';

class PasswordsDontMatchException extends ApplicationException {
  PasswordsDontMatchException() : super(message: 'Passwords dont match');
}
