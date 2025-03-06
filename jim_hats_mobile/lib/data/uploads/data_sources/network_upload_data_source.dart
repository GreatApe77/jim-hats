import 'package:dio/dio.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/uploads/data_sources/upload_data_source.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/core/network/http_client.dart';

class NetworkUploadDataSource implements UploadDataSource {
  final HttpService _httpClient;

  NetworkUploadDataSource({required HttpService httpClient})
      : _httpClient = httpClient;
  @override
  Future<String> uploadFile(UploadDto uploadDto) async {
    try {
      final response = await _httpClient.uploadFile(
        '/uploads',
        filePath: uploadDto.fileToUpload.path,
        fileField: 'file',
      );
      return response['data']['fullPath'];
    } catch (e) {
      rethrow;
    }
  }
}
