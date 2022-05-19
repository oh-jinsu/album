import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final _storage = const FlutterSecureStorage();

  String? _accessToken;

  Future<String?> findAccessToken() async {
    return _accessToken;
  }

  Future<String> saveAccessToken(String value) async {
    _accessToken = value;

    return _accessToken!;
  }

  Future<void> deleteAccessToken() async {
    _accessToken = null;
  }

  Future<String?> findRefreshToken() async {
    final result = await _storage.read(key: "refresh_token");

    return result;
  }

  Future<void> saveRefreshToken(String value) async {
    await _storage.write(key: "refresh_token", value: value);
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: "refresh_token");
  }
}
