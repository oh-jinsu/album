import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/failure_unexpected.dart';
import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/application/events/signin/signed_in_with_guest.dart';
import 'package:album/application/events/user/found.dart';
import 'package:album/application/events/user/prefetched.dart';
import 'package:album/application/models/user/user.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/infrastructure/services/jwt/jwt.dart';
import 'package:album/utilities/dependency.dart';
import "package:codux/codux.dart";

class FetchUserAfterSignInEffect extends Effect with AuthEffectMixin {
  FetchUserAfterSignInEffect() {
    on<SignedIn>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final jwtService = Dependency.find<JwtService>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final claim = await jwtService.extract(accessToken);

      if (claim["grd"] == "member") {
        final response = await withAuth((client) => client.get("user/me"));

        if (response is! SuccessResponse) {
          return dispatch(const FailureUnexpected("예기치 못한 오류입니다."));
        }

        final model = UserModel.fromJson(response.body);

        dispatch(UserFound(model));
      }

      dispatch(const UserPrefetched());
    });
    on<SignedInWithGuest>((event) async {
      final response = await withAuth((client) => client.post("user/guest"));

      if (response is! SuccessResponse) {
        return dispatch(const FailureUnexpected("예기치 못한 오류입니다."));
      }

      dispatch(const UserPrefetched());
    });
  }
}
