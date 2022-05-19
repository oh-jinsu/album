import 'package:codux/codux.dart';

class Pushed implements Event {
  final String name;
  final Map<String, dynamic>? arguments;

  const Pushed(
    this.name, {
    this.arguments,
  });
}
