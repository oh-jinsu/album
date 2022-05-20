import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/application/events/user/found.dart';
import 'package:album/application/models/user/user.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class FetchUserEffect extends Effect {
  FetchUserEffect() {
    on<SignedIn>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();

      final clientService = Dependency.inject<ClientService>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final response = await clientService.get("user/me", headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response is! SuccessResponse) {
        return;
      }

      final model = UserModel.fromJson(response.body);

      dispatch(UserFound(model));
    });
  }
}
