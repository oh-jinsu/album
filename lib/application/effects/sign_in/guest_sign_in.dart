import 'package:album/application/effects/common/client.dart';
import 'package:album/application/events/signin/guest_sign_in_requested.dart';
import 'package:album/application/events/signin/signed_in_with_guest.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class GuestSignInEffect extends Effect with ClientEffectMixin {
  GuestSignInEffect() {
    on<GuestSignInRequested>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final response = await useClient((client) => client.get("auth/guest"));

      if (response is! SuccessResponse) {
        return;
      }

      final accessToken = response.body["access_token"];
      final refreshToken = response.body["refresh_token"];

      await authRepository.saveAccessToken(accessToken);
      await authRepository.saveRefreshToken(refreshToken);

      dispatch(const SignedInWithGuest());
    });
  }
}
