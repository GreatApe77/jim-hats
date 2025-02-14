import 'package:jim_hats_mobile/shared/interfaces/validatable.dart';

class PasswordValidator  implements Validatable{
  String? password;
  PasswordValidator(
    {this.password}
  );
  @override
  bool isValid() {
    if(password==null) return false;
    return password!.length >=6 && password!.length<=20;

  }

}