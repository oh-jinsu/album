import 'dart:io';

import 'package:codux/codux.dart';

class PhotoFormSubmitted extends Event {
  final String albumId;
  final File file;
  final DateTime date;
  final String description;

  const PhotoFormSubmitted({
    required this.albumId,
    required this.file,
    required this.date,
    required this.description,
  });
}
