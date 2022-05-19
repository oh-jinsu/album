import 'package:album/events/signin/auto_sign_in_succeed.dart';
import 'package:album/events/signin/guest_sign_in_succeed.dart';
import 'package:album/events/user/found.dart';
import 'package:album/events/user/prefetched.dart';
import 'package:album/models/user/user.dart';
import 'package:album/repositories/auth.dart';
import 'package:album/services/client/client.dart';
import 'package:album/services/client/response.dart';
import 'package:album/utils/dependency.dart';
import "package:codux/codux.dart";

class PrefetchUserEffect extends Effect {
  PrefetchUserEffect() {
    on<AutoSignInSucceed>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();
      final clientService = Dependency.inject<ClientService>();

      final accessToken = await authRepository.findAccessToken();

      final response = await clientService.get("user/me", headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response is! SuccessResponse) {
        return;
      }

      final model = UserModel.fromJson(response.body);

      dispatch(UserFound(model));

      dispatch(const UserPrefetched());
    });
    on<GuestSignInSucceed>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();
      final clientService = Dependency.inject<ClientService>();

      final accessToken = await authRepository.findAccessToken();

      final response = await clientService.post("user/guest", headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response is! SuccessResponse) {
        return;
      }

      final model = UserModel.fromJson(response.body);

      dispatch(UserFound(model));

      dispatch(const UserPrefetched());
    });
  }
}
