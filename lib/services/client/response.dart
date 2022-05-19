abstract class Response {
  const Response();
}

class SuccessResponse extends Response {
  final dynamic body;

  const SuccessResponse({
    required this.body,
  });
}

class FailureResponse extends Response {
  final int code;
  final String message;

  const FailureResponse({
    required this.code,
    required this.message,
  });
}
