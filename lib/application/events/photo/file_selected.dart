import 'dart:io';

import 'package:codux/codux.dart';

class PhotoFormFileSelected extends Event {
  final File value;

  const PhotoFormFileSelected(this.value);
}
