import 'package:album/application/events/album/form_pending.dart';
import 'package:album/application/events/album/form_title_changed.dart';
import 'package:album/application/models/album/form.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';
import "package:codux/codux.dart";

const initialState = AlbumFormModel(
  title: "",
  message: null,
  state: SubmitFormState.disabled,
);

class AlbumFormStore extends Store<AlbumFormModel> {
  AlbumFormStore() : super(initialState: initialState) {
    on<AlbumFormTitleChanged>((current, event) {
      if (current.state.state == ButtonState.pending) {
        return current.state;
      }

      final copy = current.state.copy(title: New(event.value));

      if (event.value.isEmpty) {
        return copy.copy(
          message: const New("제목은 1글자보다 길어야 해요."),
          state: const New(SubmitFormState.disabled),
        );
      }

      if (event.value.length > 24) {
        return copy.copy(
          message: const New("제목은 24글자보다 짧아야 해요."),
          state: const New(SubmitFormState.disabled),
        );
      }

      return copy.copy(
        message: const New(null),
        state: const New(SubmitFormState.enabled),
      );
    });
    on<AlbumFormPending>((current, event) {
      return current.state.copy(
        state: const New(SubmitFormState.pending),
      );
    });
  }
}
