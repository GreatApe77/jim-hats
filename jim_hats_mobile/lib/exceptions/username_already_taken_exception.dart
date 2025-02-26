import 'package:jim_hats_mobile/shared/utils/application_exception.dart';

class UsernameAlreadyTakenException extends ApplicationException {
  UsernameAlreadyTakenException() : super(message: "Username already taken");
}
