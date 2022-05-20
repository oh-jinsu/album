import 'dart:convert';

class JwtService {
  Future<Map<String, dynamic>> extract(String token) async {
    final normal = base64Url.normalize(token.split(".")[1]);

    final result = jsonDecode(utf8.decode(base64Url.decode(normal)));

    return result;
  }
}
