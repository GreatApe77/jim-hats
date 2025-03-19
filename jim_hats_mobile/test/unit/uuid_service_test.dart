import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/uuid_service.dart';




void main() {
  final String invalidUuid = 'notuuid';
  final String validUuid = 'a7943b35-b62c-41c0-afd8-2f0434d8ea3c';
  late UuidService sut;

  setUp(
    () {
      sut = UuidService();
    },
  );
  test('Should return true if the uuid is valid', () {
    expect(sut.isValid(validUuid), isTrue);
  });
  test(
    'Should return false if the uuid is not valid',
    () {
      expect(sut.isValid(invalidUuid), isFalse);
    },
  );
}
