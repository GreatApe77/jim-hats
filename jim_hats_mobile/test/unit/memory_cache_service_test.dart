import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/memory_cache_service.dart';

void main() {
  late MemoryCacheService sut;
  final sampleKey1 = 'sampleKey1';
  final sampleKey2 = 'sampleKey2';
  final sampleValue1 = 'Mateus';
  final sampleValue2 = [
    {'sample': 'value'}
  ];
  setUp(
    () {
      sut = MemoryCacheService();
    },
  );

  test(
    'Should store a value and sets its invalidate time',
    () {
      fakeAsync(
        (async) {
          sut.store<String>(sampleKey1, sampleValue1,
              duration: Duration(seconds: 60));
          async.elapse(Duration(seconds: 59));
          expect(sut.get<String>(sampleKey1), sampleValue1);
        },
      );
    },
  );
  test(
    'Should invalidate cache after invalidate time passed',
    () {
      fakeAsync(
        (async) {
          sut.store<String>(sampleKey1, sampleValue1,
              duration: Duration(seconds: 60));
          async.elapse(Duration(seconds: 62));
          final result = sut.get<String>(sampleKey1);
          expect(result, isNull);
        },
      );
    },
  );
  test(
    'Should remove cache when called remove',
    () {
      fakeAsync(
        (async) {
          sut.store<List>(
            sampleKey1,
            sampleValue2,
          );
          final resultBeforeRemove = sut.get<List>(sampleKey1);
          sut.remove(sampleKey1);
          final resultAfterRemove = sut.get<List>(sampleKey1);

          expect(resultBeforeRemove, isA<List>());
          expect(resultAfterRemove, isNull);
        },
      );
    },
  );
  test(
    'Should clear cache',
    () {
      fakeAsync(
        (async) {
          final key3 = 'key3';
          int value3 = 77;
          sut.store<String>(sampleKey1, sampleKey1);
          sut.store<int>(key3, value3);
          sut.store<List>(sampleKey2, sampleValue2);
          sut.clearCache();
          final result1 = sut.get<String>(sampleKey1);
          final result2 = sut.get<int>(key3);
          final result3 = sut.get<List>(sampleKey2);
          expect(result1, isNull);
          expect(result2, isNull);
          expect(result3, isNull);
        },
      );
    },
  );
}
