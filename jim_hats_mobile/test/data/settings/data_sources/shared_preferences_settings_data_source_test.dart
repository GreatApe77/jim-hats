import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/shared_preferences_settings_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _SampleCustomTypeForTesting {}

void main() {
  late SharedPreferencesSettingsDataSource sut;
  setUp(
    () {
      SharedPreferences.setMockInitialValues({});
      sut = SharedPreferencesSettingsDataSource();
    },
  );
  test(
    'Should get an integer value',
    () async {
      SharedPreferences.setMockInitialValues({'mynum': 99});
      final result = await sut.get<int>('mynum');
      expect(result, 99);
    },
  );
  test(
    'Should get a String value',
    () async {
      SharedPreferences.setMockInitialValues({'mystr': 'somevalue'});
      final result = await sut.get<String>('mystr');
      expect(result, 'somevalue');
    },
  );
  test(
    'Should get a String value',
    () async {
      SharedPreferences.setMockInitialValues({'mystr': 'somevalue'});
      final result = await sut.get<String>('mystr');
      expect(result, 'somevalue');
    },
  );
  test(
    'Should get a double value',
    () async {
      final testDoubleValue = 3.14;

      SharedPreferences.setMockInitialValues({'doublevalue': testDoubleValue});
      final result = await sut.get<double>('doublevalue');
      expect(result, testDoubleValue);
    },
  );
  test(
    'Should get a boolean value',
    () async {
      final testBooleanValue = true;

      SharedPreferences.setMockInitialValues({'testbool': testBooleanValue});
      final result = await sut.get<bool>('testbool');
      expect(result, testBooleanValue);
    },
  );
  test(
    'Should get a list of strings',
    () async {
      final testListString = ['item1', 'item2'];

      SharedPreferences.setMockInitialValues(
          {'testlistString': testListString});
      final result = await sut.get<List<String>>('testlistString');
      expect(
        result,
        isA<List<String>>()
            .having(
              (data) => data[0],
              'First item',
              'item1',
            )
            .having(
              (data) => data[1],
              'Second item',
              'item2',
            ),
      );
    },
  );
  test(
    'Should Throw an unsuported type error',
    () async {
      SharedPreferences.setMockInitialValues({});
      expect(
        sut.get<_SampleCustomTypeForTesting>('somekey'),
        throwsUnsupportedError,
      );
    },
  );
  test(
    'Should set a String',
    () async {
      SharedPreferences.setMockInitialValues({});
      final testStringValue = 'hello';
      await expectLater(
        sut.set('someStrings', testStringValue),
        completes,
      );
    },
  );
  test(
    'Should set an integer',
    () async {
      SharedPreferences.setMockInitialValues({});
      final testIntValue = 99;
      await expectLater(
        sut.set<int>('someint', testIntValue),
        completes,
      );
    },
  );
  test(
    'Should set an double',
    () async {
      SharedPreferences.setMockInitialValues({});
      final testDoubleValue = 2.7;
      await expectLater(
        sut.set<double>('somedouble', testDoubleValue),
        completes,
      );
    },
  );
  test(
    'Should set a boolean value',
    () async {
      SharedPreferences.setMockInitialValues({});
      final testDoubleValue = true;
      await expectLater(
        sut.set<bool>('somebool', testDoubleValue),
        completes,
      );
    },
  );
  test(
    'Should set a list of string value',
    () async {
      SharedPreferences.setMockInitialValues({});
      final testListString = ['a', 'b'];
      await expectLater(
        sut.set<List<String>>('listString', testListString),
        completes,
      );
    },
  );
  test(
    'Should throw Unsuported exception while setting value',
    () async {
      SharedPreferences.setMockInitialValues({});
      final unsuportedTypeInstance = _SampleCustomTypeForTesting();
      await expectLater(
        sut.set<_SampleCustomTypeForTesting>('key', unsuportedTypeInstance),
        throwsUnsupportedError,
      );
    },
  );
  test(
    'Should remove a value',
    () async {
      final sampleKey = 'someKey';
      final String sampleValueToBeRemoved = 'ValueToBeRemoved';
      SharedPreferences.setMockInitialValues(
          {sampleKey: sampleValueToBeRemoved});
      final preRemove = await sut.get<String>(sampleKey);
      expect(preRemove, 'ValueToBeRemoved');
      await sut.remove(sampleKey);
      final removed = await sut.get<String>(sampleKey);
      expect(removed, isNull);
    },
  );
  test(
    'Should clear all values',
    () async {
      SharedPreferences.setMockInitialValues({
        'key1': 'value1',
        'key2': 'value2',
      });
      final preRemove = await sut.get<String>('key1');
      expect(preRemove, 'value1');
      await sut.clear();
      final sampleValue1 = await sut.get<String>('key1');
      final sampleValue2 = await sut.get<String>('key2');
      expect(sampleValue1, isNull);
      expect(sampleValue2, isNull);
    },
  );
}
