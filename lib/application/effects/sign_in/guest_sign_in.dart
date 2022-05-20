import 'package:album/application/events/signin/guest_sign_in_requested.dart';
import 'package:album/application/events/signin/signed_in_with_guest.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class GuestSignInEffect extends Effect {
  GuestSignInEffect() {
    on<GuestSignInRequested>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();
      final clientService = Dependency.inject<ClientService>();

      final response = await clientService.get("auth/guest");

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
