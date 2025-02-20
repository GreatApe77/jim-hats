import 'package:jim_hats_mobile/data/uploads/data_sources/network_upload_data_source.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';

class UploadRepository {
  final NetworkUploadDataSource _networkUploadDataSource;

  UploadRepository({required NetworkUploadDataSource networkUploadDataSource})
      : _networkUploadDataSource = networkUploadDataSource;

  Future<String> uploadFile(UploadDto uploadDto) async {
    final String uploadedUri =
        await _networkUploadDataSource.uploadFile(uploadDto);
    return uploadedUri;
  }
}
