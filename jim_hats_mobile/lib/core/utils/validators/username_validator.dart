import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';

class UsernameValidator implements Validatable<String> {
  @override
  String? validate(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    if (username.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    if (username.length < 3 || username.length > 20) {
      return 'Username must be between 3 and 20 characters';
    }
    return null;
  }
}
