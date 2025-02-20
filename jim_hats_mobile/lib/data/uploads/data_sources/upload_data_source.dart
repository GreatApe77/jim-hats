import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';

abstract class UploadDataSource {
  ///Should upload the file to the data source and returns its URI
  Future<String> uploadFile(UploadDto uploadDto);
}