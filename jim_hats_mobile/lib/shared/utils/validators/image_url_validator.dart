import 'package:jim_hats_mobile/shared/interfaces/validatable.dart';

class ImageUrlValidator implements Validatable{
  final String? imageUrl;

  ImageUrlValidator({this.imageUrl});

  @override
  bool isValid() {
    if (imageUrl == null) {
      return true;
    }
    return imageUrl!.startsWith('https');
  }
}
