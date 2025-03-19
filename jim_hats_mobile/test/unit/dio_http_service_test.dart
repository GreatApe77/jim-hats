import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
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
  final sampleBody = {'key': 'value'};
  final sampleMappedJsonResponse = {
    'data': {'username': 'Mateus'}
  };
  final sampleErrorResponse = {
    'data': {'message': 'error message'}
  };
  // final sampleFilePath = '';
  // final sampleFileField = 'file';
  // final sampleContentType = 'image/png';

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
  test(
    'Should send a post request with a body',
    () async {
      when(
        mockDio.post(samplePath, data: sampleBody),
      ).thenAnswer(
        (_) async => Response(
          data: sampleMappedJsonResponse,
          requestOptions: RequestOptions(),
        ),
      );
      final result = await sut.post(samplePath, data: sampleBody);
      expect(result, sampleMappedJsonResponse);
    },
  );
  test(
    'Should redirect to error handler when post fails',
    () async {
      when(
        mockDio.post(samplePath, data: sampleBody),
      ).thenAnswer(
          (_) async => throw DioException(requestOptions: RequestOptions()));

      expect(
        sut.post(samplePath, data: sampleBody),
        throwsA(
          isA<HttpException>(),
        ),
      );
    },
  );
  test(
    'Should execute a put request',
    () async {
      when(
        mockDio.put(samplePath, data: sampleBody),
      ).thenAnswer(
        (_) async => Response(
          data: sampleMappedJsonResponse,
          requestOptions: RequestOptions(),
        ),
      );
      final result = await sut.put(samplePath, data: sampleBody);
      expect(result, sampleMappedJsonResponse);
    },
  );
  test(
    'Should redirect to error handler when put fails',
    () async {
      when(
        mockDio.put(samplePath, data: sampleBody),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        sut.put(samplePath, data: sampleBody),
        throwsA(
          isA<HttpException>(),
        ),
      );
    },
  );
  test(
    'Should execute a patch request',
    () async {
      when(
        mockDio.patch(samplePath, data: sampleBody),
      ).thenAnswer(
        (_) async => Response(
          data: sampleMappedJsonResponse,
          requestOptions: RequestOptions(),
        ),
      );
      final result = await sut.patch(samplePath, data: sampleBody);
      expect(result, sampleMappedJsonResponse);
    },
  );
  test(
    'Should redirect to error handler when patch fails',
    () async {
      when(
        mockDio.patch(samplePath, data: sampleBody),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        sut.patch(samplePath, data: sampleBody),
        throwsA(
          isA<HttpException>(),
        ),
      );
    },
  );
  test(
    'Should execute a delete request',
    () async {
      when(
        mockDio.delete(samplePath, data: sampleBody),
      ).thenAnswer(
        (_) async => Response(
          data: sampleMappedJsonResponse,
          requestOptions: RequestOptions(),
        ),
      );

      expect(sut.delete(samplePath), completes);
    },
  );
  test(
    'Should redirect to error handler when delete fails',
    () async {
      when(
        mockDio.delete(samplePath),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        sut.delete(samplePath),
        throwsA(
          isA<HttpException>(),
        ),
      );
    },
  );
  test(
    'Should handle a timeout by raising a timeout exception (connection timeout)',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException.connectionTimeout(
          timeout: Duration(seconds: 1),
          requestOptions: RequestOptions(),
        ),
      );
      await expectLater(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<TimeOutException>(),
        ),
      );
    },
  );
  test(
    'Should handle a timeout by raising a timeout exception (receive timeout)',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException.receiveTimeout(
          timeout: Duration(seconds: 1),
          requestOptions: RequestOptions(),
        ),
      );
      await expectLater(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<TimeOutException>(),
        ),
      );
    },
  );
  test(
    'Should handle NetworkException when the dio exception is unknown',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException(
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(),
        ),
      );
      expect(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<NetworkException>(),
        ),
      );
    },
  );
  test(
    'Should handle Dio Exception with unknown status code by raising a generic HttpException',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException(
          type: DioExceptionType.badResponse,
          response: null,
          requestOptions: RequestOptions(),
        ),
      );
      await expectLater(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<HttpException>(),
        ),
      );
    },
  );
  test(
    'Should handle a bad request response',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
          response: Response(
              requestOptions: RequestOptions(),
              statusCode: 400,
              data: sampleErrorResponse),
        ),
      );
      expect(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<BadRequestException>(),
        ),
      );
    },
  );
  test(
    'Should handle unauthorized response',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
          response: Response(
              requestOptions: RequestOptions(),
              statusCode: 401,
              data: sampleErrorResponse),
        ),
      );
      expect(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<UnauthorizedException>(),
        ),
      );
    },
  );
  test(
    'Should handle 404 not found response',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
          response: Response(
              requestOptions: RequestOptions(),
              statusCode: 404,
              data: sampleErrorResponse),
        ),
      );
      expect(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<NotFoundException>(),
        ),
      );
    },
  );
  test(
    'Should handle an internal server error response ',
    () async {
      when(
        mockDio.get(samplePath, queryParameters: sampleQueryParams),
      ).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
          response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
              data: sampleErrorResponse),
        ),
      );
      expect(
        sut.get(samplePath, queryParameters: sampleQueryParams),
        throwsA(
          isA<ServerException>(),
        ),
      );
    },
  );
 
}
