import 'package:codux/codux.dart';

class FilmCounted implements Event {
  final int value;

  const FilmCounted(this.value);
}
