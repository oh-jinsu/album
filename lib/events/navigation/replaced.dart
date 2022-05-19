import 'package:codux/codux.dart';

class Replaced implements Event {
  final String name;
  final Map<String, dynamic>? arguments;

  const Replaced(
    this.name, {
    this.arguments,
  });
}
