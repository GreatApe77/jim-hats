import 'package:dio/dio.dart';

const localhost = 'http://localhost:4000';
const mobileLocalhost = 'http://10.0.2.2:4000';

class HttpClient {
  final Dio _dio;
  Dio get dio => _dio;
  HttpClient({required Dio dio}) : _dio = dio {
    dio.options.baseUrl = mobileLocalhost;
    dio.options.headers = {'Accept': "apllication/json"};
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 5);
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        return handler.reject(error);
      },
    ));
  }
}
