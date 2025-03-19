import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';

class PasswordValidator implements Validatable<String> {
  @override
  String? validate(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6 || password.length > 20) {
      return 'Password must be between 6 and 20 characters';
    }
    return null;
  }
}
