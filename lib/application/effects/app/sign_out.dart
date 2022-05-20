import 'package:album/application/events/auth/sign_out_form_pending.dart';
import 'package:album/application/events/auth/sign_out_requested.dart';
import 'package:album/application/events/auth/signed_out.dart';
import 'package:album/application/events/signin/guest_sign_in_requested.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SignOutEffect extends Effect {
  SignOutEffect() {
    on<SignOutRequested>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final client = Dependency.find<Client>();

      dispatch(const SignOutFormPending());

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final response = await client.auth(accessToken).post("auth/signout");

      if (response is! SuccessResponse) {
        return;
      }

      await authRepository.deleteAccessToken();

      await authRepository.deleteRefreshToken();

      dispatch(const SignedOut());

      dispatch(const GuestSignInRequested());
    });
  }
}
