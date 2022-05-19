import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';

class AlbumFormModel {
  final String title;
  final String? message;
  final SubmitFormState state;

  const AlbumFormModel({
    required this.title,
    required this.message,
    required this.state,
  });

  AlbumFormModel copy({
    New<String>? title,
    New<String?>? message,
    New<SubmitFormState>? state,
  }) {
    return AlbumFormModel(
      title: title != null ? title.value : this.title,
      message: message != null ? message.value : this.message,
      state: state != null ? state.value : this.state,
    );
  }
}
