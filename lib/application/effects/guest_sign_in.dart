import 'package:album/application/events/signin/auto_sign_in_failed.dart';
import 'package:album/application/events/signin/guest_sign_in_succeed.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utility/dependency.dart';
import 'package:codux/codux.dart';

class GuestSignInEffect extends Effect {
  GuestSignInEffect() {
    on<AutoSignInFailed>((event) async {
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

      dispatch(const GuestSignInSucceed());
    });
  }
}
