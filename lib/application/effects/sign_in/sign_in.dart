import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/application/events/auth/third_party_account_found.dart';
import 'package:album/application/events/navigation/replaced.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SignInEffect extends Effect {
  SignInEffect() {
    on<ThirdPartyAccountFound>(
      (event) async {
        final authRepository = Dependency.find<AuthRepository>();

        final client = Dependency.find<Client>();

        final response = await client.body({
          "id_token": event.idToken,
        }).post("auth/signin?provider=${event.provider}");

        if (response is FailureResponse) {
          if (response.code == 2) {
            dispatch(Replaced("/signup", arguments: {
              "provider": event.provider,
              "id_token": event.idToken,
              "name": event.name,
              "email": event.email,
            }));
          }

          return;
        } else if (response is! SuccessResponse) {
          throw Error();
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
