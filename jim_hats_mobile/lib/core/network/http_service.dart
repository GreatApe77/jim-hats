abstract class HttpService {
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Map<String, dynamic>> post(String path, {dynamic data});
  Future<Map<String, dynamic>> put(String path, {dynamic data});
  Future<Map<String, dynamic>> patch(String path, {dynamic data});
  Future<void> delete(String path);
  Future<Map<String, dynamic>> uploadFile(
    String path, {
    required String filePath,
    required String fileField,
    String? contentType,
  });
}
