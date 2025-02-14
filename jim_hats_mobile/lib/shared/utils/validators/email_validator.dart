import 'package:jim_hats_mobile/shared/interfaces/validatable.dart';

class EmailValidator implements Validatable{
  String? email;
  EmailValidator({
    this.email
  });
  @override
  bool isValid() {
      if(email==null) return false;
      return email!.contains('@');
  }
}