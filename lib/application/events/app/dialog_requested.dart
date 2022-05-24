import 'package:codux/codux.dart';

class DialogRequested implements Event {
  final String message;

  const DialogRequested(this.message);
}
