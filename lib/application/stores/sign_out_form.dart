import 'package:album/application/events/auth/sign_out_form_pending.dart';
import 'package:album/application/events/auth/signed_out.dart';
import 'package:album/application/models/auth/sign_out_form.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:codux/codux.dart';

const initialState = SignOutFormModel(isPending: false);

class SignOutFormStore extends Store<SignOutFormModel> {
  SignOutFormStore() : super(initialState: initialState) {
    on<SignOutFormPending>((current, event) {
      return current.state.copy(isPending: const New(true));
    });
    on<SignedOut>((current, event) {
      return current.state.copy(isPending: const New(false));
    });
  }
}
