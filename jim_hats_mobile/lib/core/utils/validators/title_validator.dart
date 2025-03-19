import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';

class TitleValidator implements Validatable<String> {
  @override
  String? validate(String? exerciseLogTitle) {
    if (exerciseLogTitle == null || exerciseLogTitle.isEmpty) {
      return 'Title is required';
    }
    return null;
  }
}
