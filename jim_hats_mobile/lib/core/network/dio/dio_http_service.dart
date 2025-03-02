import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/settings/data_sources/settings_data_source.dart';

class DioHttpService implements HttpService {
  final SettingsDataSource _settingsDataSource;
  final Dio _dio;
  DioHttpService({
    required SettingsDataSource settingsDataSource,
    required Dio dio,
  })  : _dio = dio,
        _settingsDataSource = settingsDataSource {
    _dio.options = BaseOptions(
      baseUrl: 'http://10.0.2.2:4000',
      headers: {'Accept': "application/json"},
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _settingsDataSource.get<String>('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  @override
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> patch(String path, {data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> delete(String path) async {
    try {
      await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return BadRequestException(
              e.response?.data['message'] ?? 'Bad Request');
        case 401:
          return UnauthorizedException(
              e.response?.data['message'] ?? 'Unauthorized');
        case 404:
          return NotFoundException(e.response?.data['message'] ?? 'Not Found');
        case 500:
        default:
          return ServerException(e.response?.data['message'] ?? 'Server Error');
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return TimeOutException();
    } else if (e.type == DioExceptionType.unknown) {
      return NetworkException('No Internet connection.');
    }
    return HttpException('Unexpected error occurred.');
  }
}
