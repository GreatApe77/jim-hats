import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';

class ImageUrlValidator implements Validatable<String> {
  @override
  String? validate(String? imageUrl) {
    if (imageUrl == null) {
      return null;
    }
    if (!imageUrl.startsWith('https')) {
      return 'Invalid image url';
    }
    return null;
  }
}
