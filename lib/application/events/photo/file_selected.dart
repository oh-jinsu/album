import 'dart:io';

import 'package:codux/codux.dart';

class PhotoFormFileSelected implements Event {
  final File value;

  const PhotoFormFileSelected(this.value);
}
