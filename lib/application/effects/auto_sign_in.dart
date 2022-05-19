import 'package:album/application/events/bootstrap/bootstrap_finished.dart';
import 'package:album/application/events/signin/auto_sign_in_failed.dart';
import 'package:album/application/events/signin/auto_sign_in_succeed.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class AutoSignInEffect extends Effect {
  AutoSignInEffect() {
    on<AppReady>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();

      final clientService = Dependency.inject<ClientService>();

      final refreshToken = await authRepository.findRefreshToken();

      if (refreshToken == null) {
        return dispatch(const AutoSignInFailed());
      }

      final response = await clientService.post("auth/refresh", body: {
        "refresh_token": refreshToken,
      });

      if (response is! SuccessResponse) {
        return dispatch(const AutoSignInFailed());
      }

      final accessToken = response.body["access_token"];

      await authRepository.saveAccessToken(accessToken);

      dispatch(const AutoSignInSucceed());
    });
  }
}
