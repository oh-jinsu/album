import 'dart:convert';
import 'dart:io';

import 'package:album/services/client/response.dart';
import 'package:album/utils/debug.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

typedef Fetcher = Future<http.Response> Function(
  Uri uri, {
  Map<String, String>? headers,
});

class ClientService {
  Future<Response> get(
    String endpoint, {
    Map<String, String> headers = const {},
  }) async {
    Debug.log("GET $endpoint");

    return _fetch(endpoint, http.get, headers: headers);
  }

  Future<Response> post(
    String endpoint, {
    Map<String, String> headers = const {},
    Object body = const {},
  }) async {
    Debug.log("POST $endpoint");

    final postHeaders = <String, String>{};

    postHeaders.addAll(headers);

    postHeaders["Content-Type"] = "application/json;charset=utf-8";

    Debug.log(jsonEncode(body));

    return _fetch(
      endpoint,
      (Uri uri, {Map<String, String>? headers}) => http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      ),
      headers: postHeaders,
    );
  }

  Future<Response> postMultipart(
    String endpoint,
    File file, {
    Map<String, String> headers = const {},
  }) async {
    final request = http.MultipartRequest("POST", _getUri(endpoint));

    request.headers.addAll(headers);

    final mutlipartFile = await http.MultipartFile.fromPath("file", file.path);

    request.files.add(mutlipartFile);

    try {
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      return _parseResponse(response);
    } catch (e) {
      Debug.log(e);

      await Future.delayed(const Duration(milliseconds: 1000));

      return postMultipart(endpoint, file);
    }
  }

  Uri _getUri(String endpoint) =>
      Uri.parse("${dotenv.get("API_HOST")}/$endpoint");

  Future<Response> _fetch(
    String endpoint,
    Fetcher fetcher, {
    required Map<String, String> headers,
  }) async {
    try {
      Debug.log(headers);

      final response = await fetcher(_getUri(endpoint), headers: headers);

      return _parseResponse(response);
    } catch (e) {
      Debug.log(e);

      await Future.delayed(const Duration(milliseconds: 1000));

      return _fetch(endpoint, fetcher, headers: headers);
    }
  }

  Response _parseResponse(http.Response response) {
    Debug.log(response.statusCode);

    Debug.log(response.body);

    if (response.statusCode == 204) {
      return const SuccessResponse(body: null);
    }

    if (response.statusCode.toString().startsWith("2")) {
      return SuccessResponse(body: jsonDecode(response.body));
    }

    final body = jsonDecode(response.body);

    final code = body["code"];

    final message = body["message"];

    return FailureResponse(code: code, message: message);
  }
}
