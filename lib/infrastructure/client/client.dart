import 'dart:convert';

import 'package:album/core/utilities/debug.dart';
import 'package:album/infrastructure/client/response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

typedef Fetcher = Future<http.Response> Function(
  Uri uri, {
  Map<String, String>? headers,
});

class Client {
  Future<Response> get(String endpoint, {Map<String, String>? headers}) async {
    Debug.log("GET $endpoint");

    return _fetch(endpoint, http.get, headers: headers);
  }

  Future<Response> post(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    Debug.log("POST $endpoint");

    return _fetch(
      endpoint,
      (Uri uri, {Map<String, String>? headers}) => http.post(
        uri,
        headers: headers,
        body: body,
      ),
      headers: headers,
    );
  }

  Future<Response> _fetch(
    String endpoint,
    Fetcher fetcher, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await fetcher(
          Uri.parse("${dotenv.get("API_HOST")}/$endpoint"),
          headers: headers);

      Debug.log(response.statusCode);

      final body = jsonDecode(response.body);

      Debug.log(body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SuccessResponse(body: body);
      }

      final code = body["code"];

      final message = body["message"];

      return FailureResponse(code: code, message: message);
    } catch (e) {
      Debug.log(e);

      await Future.delayed(const Duration(milliseconds: 1000));

      return _fetch(endpoint, fetcher, headers: headers);
    }
  }
}
