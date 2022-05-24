import 'package:album/application/effects/common/client.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/application/events/auth/third_party_account_found.dart';
import 'package:album/application/events/navigation/replaced.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SignInEffect extends Effect with ClientEffectMixin {
  SignInEffect() {
    on<ThirdPartyAccountFound>(
      (event) async {
        final authRepository = Dependency.find<AuthRepository>();

        final response = await useClient(
          (client) => client.body({
            "id_token": event.idToken,
          }).post("auth/signin?provider=${event.provider}"),
        );

        if (response is FailureResponse) {
          if (response.code == 2) {
            dispatch(Replaced("/signup", arguments: {
              "provider": event.provider,
              "id_token": event.idToken,
              "name": event.name,
              "email": event.email,
            }));
          } else {
            dispatch(DialogRequested(response.message));
          }

          return;
        }

        if (response is! SuccessResponse) {
          return dispatch(const DialogRequested("예기치 못한 오류입니다."));
        }

        final accessToken = response.body["access_token"];

        final refreshToken = response.body["refresh_token"];

        await authRepository.saveAccessToken(accessToken);

        await authRepository.saveRefreshToken(refreshToken);

        dispatch(const SignedIn());
      },
    );
  }
}
