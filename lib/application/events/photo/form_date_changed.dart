import 'package:codux/codux.dart';

class PhotoFormDateChanged implements Event {
  final DateTime value;

  const PhotoFormDateChanged(this.value);
}
