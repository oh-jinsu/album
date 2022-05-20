import 'package:album/application/events/auth/google_sign_in_requested.dart';
import 'package:album/application/events/auth/sign_in_canceled.dart';
import 'package:album/application/events/auth/sign_in_pending.dart';
import 'package:album/application/events/auth/third_party_account_found.dart';
import 'package:codux/codux.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogleEffect extends Effect {
  SignInWithGoogleEffect() {
    on<GoogleSignInRequested>((event) async {
      dispatch(const SignInPending());

      try {
        final account = await GoogleSignIn(scopes: [
          "email",
        ]).signIn();

        if (account == null) {
          return dispatch(const SignInCanceled());
        }

        final authentication = await account.authentication;

        final idToken = authentication.idToken;

        if (idToken == null) {
          return dispatch(const SignInCanceled());
        }

        dispatch(ThirdPartyAccountFound(
          provider: "google",
          idToken: idToken,
          name: account.displayName,
          email: account.email,
        ));
      } catch (e) {
        dispatch(const SignInCanceled());
      }
    });
  }
}
