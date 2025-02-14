import 'package:jim_hats_mobile/shared/interfaces/validatable.dart';
import 'package:jim_hats_mobile/shared/utils/validators/email_validator.dart';
import 'package:jim_hats_mobile/shared/utils/validators/image_url_validator.dart';
import 'package:jim_hats_mobile/shared/utils/validators/password_validator.dart';
import 'package:jim_hats_mobile/shared/utils/validators/username_validator.dart';

class CreateAccountFormData {
  final Validatable validatableEmail = EmailValidator();
  final Validatable validatableUserName = UsernameValidator();
  final Validatable validatablePassword = PasswordValidator();
  final Validatable validatableImageUrl = ImageUrlValidator();

  
}
