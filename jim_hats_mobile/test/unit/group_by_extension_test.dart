import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/group_by_extension.dart';

void main() {
  test(
    'Should group by the name',
    () {
      final usersList = [
        {
          'name': 'John',
          'age': 30,
        },
        {
          'name': 'Jane',
          'age': 25,
        },
        {
          'name': 'Marcos',
          'age': 35,
        }
      ];
      final grouped = usersList.groupBy<String>(
        (item) => item['name'] as String,
      );
      expect(grouped['John']!.length, 1);
      expect(grouped['Jane']!.length, 1);
      expect(grouped['Marcos']!.length, 1);
    },
  );
}
