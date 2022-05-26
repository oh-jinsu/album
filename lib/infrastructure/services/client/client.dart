import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/debug.dart';

typedef _Fetcher = Future<http.Response> Function(
  Uri uri, {
  Map<String, String>? headers,
});

class Client {
  final String _host;

  File? _file;

  Object? _body;

  final Map<String, String> _headers = {};

  Client(String host) : _host = host;

  Future<Response> get(String endpoint) => _request("GET", endpoint);

  Future<Response> post(String endpoint) => _request("POST", endpoint);

  Future<Response> put(String endpoint) => _request("PUT", endpoint);

  Future<Response> patch(String endpoint) => _request("PATCH", endpoint);

  Future<Response> delete(String endpoint) => _request("DELETE", endpoint);

  Client header(String key, String value) {
    _headers[key] = value;

    return this;
  }

  Client auth(String token) {
    _headers["Authorization"] = "Bearer $token";

    return this;
  }

  Client body(Object body) {
    _body = body;

    return this;
  }

  Client file(File file) {
    _file = file;

    return this;
  }

  Future<Response> _request(String method, String endpoint) async {
    final uri = Uri.parse("$_host/$endpoint");

    final response = await _load(_file, _body)(method)(uri, headers: _headers);

    Debug.log("""
Reponsed status ${response.statusCode} from: $uri ($method)
body: ${response.body}
""");

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

  static _Fetcher Function(String method) _load(File? file, Object? body) {
    if (file != null) {
      return _requestWithFile(file);
    } else {
      return _requestWithPayloadIfExists(body);
    }
  }

  static _Fetcher Function(String method) _requestWithPayloadIfExists(
    Object? body,
  ) {
    return (method) {
      return (uri, {headers}) async {
        if (method == "GET") {
          Debug.log("""
Requested $uri ($method)
headers: $headers
""");

          return http.get(uri, headers: headers);
        }

        final fetcher = () {
          switch (method) {
            case "PUT":
              return http.put;
            case "PATCH":
              return http.patch;
            case "DELETE":
              return http.delete;
            default:
              return http.post;
          }
        }();

        headers ??= {};

        final contentType = () {
          switch (method) {
            default:
              return "application/json";
          }
        }();

        headers["Content-Type"] = "$contentType;charset=utf-8";

        Debug.log("""
Requested $uri ($method)
headers: $headers
payload: $body
""");

        return fetcher(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      };
    };
  }

  static _Fetcher Function(String method) _requestWithFile(File file) {
    return (method) {
      return (uri, {headers}) async {
        final request = http.MultipartRequest(method, uri);

        if (headers != null) {
          request.headers.addAll(headers);
        }

        final mutlipartFile =
            await http.MultipartFile.fromPath("file", file.path);

        request.files.add(mutlipartFile);

        final streamedResponse = await request.send();

        return http.Response.fromStream(streamedResponse);
      };
    };
  }
}
