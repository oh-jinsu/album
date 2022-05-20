import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/auth/sign_out_form_pending.dart';
import 'package:album/application/events/auth/sign_out_requested.dart';
import 'package:album/application/events/auth/signed_out.dart';
import 'package:album/application/events/signin/guest_sign_in_requested.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SignOutEffect extends Effect with AuthEffectMixin {
  SignOutEffect() {
    on<SignOutRequested>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      dispatch(const SignOutFormPending());

      final response = await withAuth((client) => client.post("auth/signout"));

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
