import 'package:album/application/events/auth/sign_in_canceled.dart';
import 'package:album/application/events/auth/sign_in_pending.dart';
import 'package:album/application/models/auth/sign_in_form.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:codux/codux.dart';

const initialState = SignInFormModel(isPending: false);

class SignInFormStore extends Store<SignInFormModel> {
  SignInFormStore() : super(initialState: initialState) {
    on<SignInPending>((current, event) {
      return current.state.copy(isPending: const New(true));
    });
    on<SignInCanceled>((current, event) {
      return current.state.copy(isPending: const New(false));
    });
  }
}
