import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/application/events/signin/signed_in_with_guest.dart';
import 'package:album/application/events/user/found.dart';
import 'package:album/application/events/user/prefetched.dart';
import 'package:album/application/models/user/user.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/infrastructure/services/jwt/jwt.dart';
import 'package:album/utilities/dependency.dart';
import "package:codux/codux.dart";

class FetchUserAfterSignInEffect extends Effect {
  FetchUserAfterSignInEffect() {
    on<SignedIn>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();
      final clientService = Dependency.inject<ClientService>();
      final jwtService = Dependency.inject<JwtService>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final claim = await jwtService.extract(accessToken);

      if (claim["grd"] == "member") {
        final response = await clientService.get("user/me", headers: {
          "Authorization": "Bearer $accessToken",
        });

        if (response is! SuccessResponse) {
          return;
        }

        final model = UserModel.fromJson(response.body);

        dispatch(UserFound(model));
      }

      dispatch(const UserPrefetched());
    });
    on<SignedInWithGuest>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();
      final clientService = Dependency.inject<ClientService>();

      final accessToken = await authRepository.findAccessToken();

      final response = await clientService.post("user/guest", headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response is! SuccessResponse) {
        return;
      }

      dispatch(const UserPrefetched());
    });
  }
}
