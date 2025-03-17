import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/uuid_service.dart';
import 'package:jim_hats_mobile/core/utils/validators/group_code_validator.dart';
import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'group_code_validator_test.mocks.dart';

@GenerateMocks([UuidService])
void main() {
  group(
    'Group code validator',
    () {
      // ignore: avoid_init_to_null
      String? invalidNullGroupCode = null;
      String invalidEmptyGroupCode = '';
      String validGroupCode = '387ba39a-d49b-4f73-a1c5-3d0afa8c1371';
      String notAnUuidGroupCode = 'not-uuid';
      late GroupCodeValidator groupCodeValidator;
      late MockUuidService mockUuidService;
      setUp(() {
        mockUuidService = MockUuidService();
        groupCodeValidator = GroupCodeValidator(
          uuidService: mockUuidService,
        );
      });
      test(
        'Should return null if group code is valid',
        () {
          when(mockUuidService.isValid(validGroupCode)).thenReturn(true);
          expect(groupCodeValidator.validate(validGroupCode), null);
        },
      );

      test(
        'Should be invalid because group code is null',
        () {
          String? expectedErrorMessage = 'Group code is required';
          String? result = groupCodeValidator.validate(invalidNullGroupCode);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should be invalid because group code is empty',
        () {
          String? expectedErrorMessage = 'Group code is required';
          String? result = groupCodeValidator.validate(invalidEmptyGroupCode);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should be invalid because group code is not an UUID',
        () {
          when(mockUuidService.isValid(notAnUuidGroupCode)).thenReturn(false);
          String? expectedErrorMessage = 'Invalid group code';

          String? result = groupCodeValidator.validate(notAnUuidGroupCode);
          expect(result, expectedErrorMessage);
        },
      );
    },
  );
}
