import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/validators/title_validator.dart';

void main() {
  group(
    'Title validator tests',
    () {
      String validTitle = 'Title is valid';
      // ignore: avoid_init_to_null
      String? invalidNullTitle = null;
      String invalidEmptyTitle = '';

      late TitleValidator titleValidator;
      setUp(
        () {
          titleValidator = TitleValidator();
        },
      );
      test(
        'Should be a valid title',
        () {
          final nullErrorMessage = null;
          String? result = titleValidator.validate(validTitle);
          expect(result, nullErrorMessage);
        },
      );
      test(
        'Should not be a valid title because title is null',
        () {
          final errorMessage = 'Title is required';
          String? result = titleValidator.validate(invalidNullTitle);
          expect(result, errorMessage);
        },
      );
      test(
        'Should not be a valid title because title is empty',
        () {
          final errorMessage = 'Title is required';
          String? result = titleValidator.validate(invalidEmptyTitle);
          expect(result, errorMessage);
        },
      );
    },
  );
}
