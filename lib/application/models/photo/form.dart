import 'dart:io';

import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';

class PhotoFormModel {
  final File? file;
  final DateTime date;
  final String description;
  final SubmitFormState state;

  const PhotoFormModel({
    required this.file,
    required this.date,
    required this.description,
    required this.state,
  });

  PhotoFormModel copy({
    New<File>? file,
    New<DateTime>? date,
    New<String>? description,
    New<SubmitFormState>? state,
  }) {
    return PhotoFormModel(
      file: file != null ? file.value : this.file,
      date: date != null ? date.value : this.date,
      description: description != null ? description.value : this.description,
      state: state != null ? state.value : this.state,
    );
  }
}
