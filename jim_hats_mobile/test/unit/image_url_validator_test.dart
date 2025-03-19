import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/validators/image_url_validator.dart';

void main() {
  group(
    'Image url validation tests',
    () {
      final invalidUrl = 'address.com';
      final validImageUrl = 'https://domain.com/image.png';
      late ImageUrlValidator imageUrlValidator;

      setUp(
        () {
          imageUrlValidator = ImageUrlValidator();
        },
      );

      test(
        'Should return null if provided url is valid',
        () {
          final expectedErrorMessage = null;
          final result = imageUrlValidator.validate(validImageUrl);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should return null if url is null because it is not required',
        () {
          final expectedErrorMessage = null;
          final result = imageUrlValidator.validate(null);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid image url',
        () {
          final expectedErrorMessage = 'Invalid image url';
          final result = imageUrlValidator.validate(invalidUrl);
          expect(result, expectedErrorMessage);
        },
      );
    },
  );
}
