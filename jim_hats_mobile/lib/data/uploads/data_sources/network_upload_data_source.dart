import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/data/uploads/data_sources/upload_data_source.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/shared/http/http_client.dart';

class NetworkUploadDataSource implements UploadDataSource {
  final HttpClient _httpClient;

  NetworkUploadDataSource({required HttpClient httpClient})
      : _httpClient = httpClient;
  @override
  Future<String> uploadFile(UploadDto uploadDto) async {
    final form = FormData.fromMap(
        {'file': await MultipartFile.fromFile(uploadDto.fileToUpload.path)});
    try {
      final response = await _httpClient.dio.post('/uploads',
          data: form,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
      return jsonDecode(response.data)['data']['fullPath'];
    } catch (e) {
      rethrow;
    }
  }
}
