import 'package:album/application/effects/common/client.dart';
import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/application/events/bootstrap/bootstrap_finished.dart';
import 'package:album/application/events/signin/guest_sign_in_requested.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class AutoSignInEffect extends Effect with ClientEffectMixin {
  AutoSignInEffect() {
    on<AppReady>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final refreshToken = await authRepository.findRefreshToken();

      if (refreshToken == null) {
        return dispatch(const GuestSignInRequested());
      }

      final response = await useClient((client) => client.body({
            "refresh_token": refreshToken,
          }).post("auth/refresh"));

      if (response is! SuccessResponse) {
        return dispatch(const GuestSignInRequested());
      }

      final accessToken = response.body["access_token"];

      await authRepository.saveAccessToken(accessToken);

      dispatch(const SignedIn());
    });
  }
}
