import 'package:jim_hats_mobile/shared/interfaces/validatable.dart';

class UsernameValidator  implements Validatable{

  final  String? username;
  
  UsernameValidator({this.username});

  @override
  bool isValid() {
    if(username==null) return false;
    if(username!.length <3) return false;
    if(username!.length>20) return false;
    return true;
  }

}