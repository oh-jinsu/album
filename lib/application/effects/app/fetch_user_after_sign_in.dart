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
      final authRepository = Dependency.find<AuthRepository>();
      final client = Dependency.find<Client>();
      final jwtService = Dependency.find<JwtService>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final claim = await jwtService.extract(accessToken);

      if (claim["grd"] == "member") {
        final response = await client.auth(accessToken).get("user/me");

        if (response is! SuccessResponse) {
          return;
        }

        final model = UserModel.fromJson(response.body);

        dispatch(UserFound(model));
      }

      dispatch(const UserPrefetched());
    });
    on<SignedInWithGuest>((event) async {
      final authRepository = Dependency.find<AuthRepository>();
      final client = Dependency.find<Client>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final response = await client.auth(accessToken).post("user/guest");

      if (response is! SuccessResponse) {
        return;
      }

      dispatch(const UserPrefetched());
    });
  }
}
