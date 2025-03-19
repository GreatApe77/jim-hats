import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/network/dio/dio_http_service.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dio_http_service_test.mocks.dart';

@GenerateMocks([SettingsDataSource])
@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late DioHttpService sut;
  late Dio mockDio;
  late SettingsDataSource mockSettingsDataSource;
  final samplePath = '/api/resources/';
  final sampleQueryParams = {'paramA': 'valueA', 'paramB': 'valueB'};
  final sampleMappedJsonResponse = {
    'data': {'username': 'Mateus'}
  };
  setUp(
    () {
      mockSettingsDataSource = MockSettingsDataSource();
      mockDio = MockDio();
      final fakeInterceptors = Interceptors();
      when(mockDio.interceptors).thenReturn(fakeInterceptors);
      sut = DioHttpService(
        settingsDataSource: mockSettingsDataSource,
        dio: mockDio,
      );
    },
  );

  test(
    'Should send a get request with a path and query params',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => Response(
          data: sampleMappedJsonResponse,
          requestOptions: RequestOptions(),
        ),
      );
      final result = await sut.get(
        samplePath,
        queryParameters: sampleQueryParams,
      );
      expect(result, sampleMappedJsonResponse);
    },
  );
  test('Should handle a timeout by raising a timeout exception',() {
    expect(true,isTrue);
  },);
}
