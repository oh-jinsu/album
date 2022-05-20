import 'package:album/application/events/auth/apple_sign_in_requested.dart';
import 'package:album/application/events/auth/sign_in_canceled.dart';
import 'package:album/application/events/auth/sign_in_pending.dart';
import 'package:album/application/events/auth/third_party_account_found.dart';
import 'package:codux/codux.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInWithAppleEffect extends Effect {
  SignInWithAppleEffect() {
    on<AppleSignInRequested>((event) async {
      dispatch(const SignInPending());

      try {
        final account = await SignInWithApple.getAppleIDCredential(scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]);

        final idToken = account.identityToken;

        if (idToken == null) {
          return dispatch(const SignInCanceled());
        }

        dispatch(ThirdPartyAccountFound(
          provider: "apple",
          idToken: idToken,
          name: account.givenName,
          email: account.email,
        ));
      } catch (e) {
        dispatch(const SignInCanceled());
      }
    });
  }
}
