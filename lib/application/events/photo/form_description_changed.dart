import 'package:codux/codux.dart';

class PhotoFormDescriptionChanged implements Event {
  final String value;

  const PhotoFormDescriptionChanged(this.value);
}
