import 'package:album/application/events/auth/sign_up_form_avatar_selected.dart';
import 'package:album/application/events/auth/sign_up_form_email_changed.dart';
import 'package:album/application/events/auth/sign_up_form_name_changed.dart';
import 'package:album/application/events/auth/sign_up_form_pending.dart';
import 'package:album/application/events/auth/sign_up_form_privacy_agreement_changed.dart';
import 'package:album/application/models/auth/sign_up_form.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';
import 'package:codux/codux.dart';

const initialState = SignUpFormModel(
  avatar: null,
  name: "",
  nameMessage: null,
  email: "",
  emailMessage: null,
  // isServiceAgreed: false,
  isPrivacyAgreed: false,
  state: SubmitFormState.disabled,
);

class SignUpFormStore extends Store<SignUpFormModel> {
  SignUpFormStore() : super(initialState: initialState) {
    on<SignUpFormAvatarSelected>((current, event) {
      return current.state.copy(avatar: New(event.file));
    });
    on<SignUpFormNameChanged>((current, event) {
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
        return nameChangedState.copy(
          state: const New(SubmitFormState.enabled),
        );
      }

      return nameValidatedState.copy(
        nameMessage: const New(null),
      );
    });
    on<SignUpFormEmailChanged>((current, event) {
      return current.state.copy(email: New(event.value));
    });
    // on<SignUpFormServiceAgreementChanged>((current, event) {
    //   final serviceAgreementChangedState = current.state.copy(
    //     isServiceAgreed: New(event.value),
    //   );

    //   if (_isValidated(serviceAgreementChangedState)) {
    //     return serviceAgreementChangedState.copy(
    //       state: const New(SubmitFormState.enabled),
    //     );
    //   }

    //   return serviceAgreementChangedState.copy(
    //     state: const New(SubmitFormState.disabled),
    //   );
    // });
    on<SignUpFormPrivacyAgreementChanged>((current, event) {
      final privacyAgreementChangedState = current.state.copy(
        isPrivacyAgreed: New(event.value),
      );

      if (_isValidated(privacyAgreementChangedState)) {
        return privacyAgreementChangedState.copy(
          state: const New(SubmitFormState.enabled),
        );
      }

      return privacyAgreementChangedState.copy(
        state: const New(SubmitFormState.disabled),
      );
    });
    on<SignUpFormPending>((current, event) {
      return current.state.copy(state: const New(SubmitFormState.pending));
    });
  }

  static bool _isValidated(SignUpFormModel state) {
    if (!state.isPrivacyAgreed) {
      return false;
    }

    // if (!state.isServiceAgreed) {
    //   return false;
    // }

    if (state.name.isEmpty) {
      return false;
    }

    if (state.name.length > 12) {
      return false;
    }

    return true;
  }
}
