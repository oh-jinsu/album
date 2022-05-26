import 'package:album/application/events/user/profile_fom_failed.dart';
import 'package:album/application/events/user/profile_form_avatar_selected.dart';
import 'package:album/application/events/user/profile_form_email_changed.dart';
import 'package:album/application/events/user/profile_form_name_changed.dart';
import 'package:album/application/events/user/profile_form_pending.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';
import 'package:album/application/models/user/profile_form.dart';
import 'package:codux/codux.dart';

const initialState = ProfileFormModel(
  avatar: null,
  name: null,
  nameMessage: null,
  email: null,
  emailMessage: null,
  state: SubmitFormState.enabled,
);

class ProfileFormStore extends Store<ProfileFormModel> {
  ProfileFormStore() : super(initialState: initialState) {
    on<ProfileFormAvatarSelected>((current, event) {
      return current.state.copy(avatar: New(event.file));
    });
    on<ProfileFormNameChanged>((current, event) {
      final nameChangedState = current.state.copy(
        name: New(event.value),
      );

      if (event.value.isEmpty) {
        return nameChangedState.copy(
          nameMessage: const New("이름은 1글자보다 길어야 해요."),
          state: const New(SubmitFormState.disabled),
        );
      }

      if (event.value.length > 12) {
        return nameChangedState.copy(
          nameMessage: const New("이름은 12글자를 넘기지 않아야 해요."),
          state: const New(SubmitFormState.disabled),
        );
      }

      final nameValidatedState = nameChangedState.copy(
        nameMessage: const New(null),
      );

      if (_isValidated(nameValidatedState)) {
        return nameValidatedState.copy(
          state: const New(SubmitFormState.enabled),
        );
      }

      return nameValidatedState;
    });
    on<ProfileFormEmailChanged>((current, event) {
      return current.state.copy(email: New(event.value));
    });
    on<ProfileFormPending>((current, event) {
      return current.state.copy(state: const New(SubmitFormState.pending));
    });
    on<ProfileFormFailed>((current, event) {
      return current.state.copy(state: const New(SubmitFormState.enabled));
    });
  }

  static bool _isValidated(ProfileFormModel state) {
    if (state.name != null) {
      if (state.name!.isEmpty) {
        return false;
      }

      if (state.name!.length > 12) {
        return false;
      }
    }

    return true;
  }
}
