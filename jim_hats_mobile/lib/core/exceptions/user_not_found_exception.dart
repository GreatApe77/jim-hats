import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class UserNotFoundException extends ApplicationException {
  UserNotFoundException() : super(message: 'User not found');
}