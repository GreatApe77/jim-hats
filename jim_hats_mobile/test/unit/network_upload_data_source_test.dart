import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/network/http_service.dart';
import 'package:jim_hats_mobile/data/uploads/data_sources/network_upload_data_source.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_upload_data_source_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  late NetworkUploadDataSource sut;
  late HttpService mockHttpClient;
  final sampleUploadDto = UploadDto(fileToUpload: XFile('EMPTY'));
  final sampleResultUrl = 'https://sample.com';
  setUp(
    () {
      mockHttpClient = MockHttpService();
      sut = NetworkUploadDataSource(httpClient: mockHttpClient);
    },
  );

  test(
    'Should upload file to httpClient and returning the uploaded url',
    () async {
      when(
        mockHttpClient.uploadFile('/uploads',
            filePath: sampleUploadDto.fileToUpload.path, fileField: 'file'),
      ).thenAnswer(
        (_) async => {
          'data': {'fullPath': sampleResultUrl}
        },
      );
      final result = await sut.uploadFile(sampleUploadDto);
      expect(result, sampleResultUrl);
    },
  );
}
