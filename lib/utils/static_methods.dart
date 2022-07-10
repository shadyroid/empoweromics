import 'package:http/http.dart' as http;

class StaticMethods {
  static Future<http.MultipartFile> getImageRequestBody(
      String path, String name) async {
    return await http.MultipartFile.fromPath(name, path);
  }
}
