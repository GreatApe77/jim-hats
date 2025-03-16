import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';

class EmailValidator implements Validatable<String> {
  @override
  String? validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
