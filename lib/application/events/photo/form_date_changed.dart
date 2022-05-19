import 'package:codux/codux.dart';

class PhotoFormDateChanged extends Event {
  final DateTime value;

  const PhotoFormDateChanged(this.value);
}
