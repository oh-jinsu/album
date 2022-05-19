import 'package:album/application/events/photo/form_date_changed.dart';
import 'package:album/application/events/photo/form_description_changed.dart';
import 'package:album/application/events/photo/pending.dart';
import 'package:album/application/events/photo/file_selected.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';
import 'package:album/application/models/photo/form.dart';
import 'package:codux/codux.dart';

final initialState = PhotoFormModel(
  file: null,
  date: DateTime.now(),
  description: "",
  state: SubmitFormState.disabled,
);

class PhotoFormStore extends Store<PhotoFormModel> {
  PhotoFormStore() : super(initialState: initialState) {
    on<PhotoFormFileSelected>((current, event) {
      return current.state.copy(
        file: New(event.value),
        state: const New(SubmitFormState.enabled),
      );
    });
    on<PhotoFormDateChanged>((current, event) {
      return current.state.copy(
        date: New(event.value),
      );
    });
    on<PhotoFormDescriptionChanged>((current, event) {
      return current.state.copy(
        description: New(event.value),
      );
    });
    on<PhotoFormPending>((current, event) {
      return current.state.copy(
        state: const New(SubmitFormState.pending),
      );
    });
  }
}
