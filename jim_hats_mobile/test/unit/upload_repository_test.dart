import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/data/uploads/data_sources/upload_data_source.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_repository_test.mocks.dart';

@GenerateMocks([UploadDataSource, XFile])
void main() {
  late UploadRepository sut;
  late UploadDataSource mockUploadDataSource;
  final sampleUploadDto = UploadDto(fileToUpload: XFile(''));
  final sampleUploadResponse = 'https://upluoaded.com';
  setUp(
    () {
      mockUploadDataSource = MockUploadDataSource();
      sut = UploadRepository(
        networkUploadDataSource: mockUploadDataSource,
      );
    },
  );

  test(
    'Should upload file and return its url',
    () async {
      when(mockUploadDataSource.uploadFile(sampleUploadDto)).thenAnswer(
        (_) async => sampleUploadResponse,
      );

      final result = await sut.uploadFile(sampleUploadDto);
      expect(result,sampleUploadResponse);
    },
  );
}
