import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class UsernameAlreadyTakenException extends ApplicationException {
  UsernameAlreadyTakenException() : super(message: "Username already taken");
}
