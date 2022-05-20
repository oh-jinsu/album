import 'package:codux/codux.dart';

class FailureUnexpected implements Event {
  final String message;
  const FailureUnexpected(this.message);
}
