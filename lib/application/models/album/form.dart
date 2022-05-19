import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';

class AlbumFormModel {
  final String title;
  final String? message;
  final SubmitFormState submitFormState;

  const AlbumFormModel({
    required this.title,
    required this.message,
    required this.submitFormState,
  });

  AlbumFormModel copy({
    New<String>? title,
    New<String?>? message,
    New<SubmitFormState>? submitFormState,
  }) {
    return AlbumFormModel(
      title: title != null ? title.value : this.title,
      message: message != null ? message.value : this.message,
      submitFormState: submitFormState != null
          ? submitFormState.value
          : this.submitFormState,
    );
  }
}
