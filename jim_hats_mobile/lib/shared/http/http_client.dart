import 'package:dio/dio.dart';
const localhost ='http://localhost:3000';
const mobileLocalhost = 'http://10.0.2.2:3000';
class HttpClient {
  final Dio _dio;
  Dio get dio => _dio;
  HttpClient({required Dio dio}) : _dio = dio {
    dio.options.baseUrl = mobileLocalhost;
    dio.options.headers ={
      'Accept':"apllication/json"
    };
    dio.options.connectTimeout = Duration(seconds: 2);
    dio.options.receiveTimeout = Duration(seconds: 3);
  }
}