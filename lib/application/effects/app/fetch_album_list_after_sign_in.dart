import 'package:album/application/events/album/list_of_found.dart';
import 'package:album/application/events/user/prefetched.dart';
import 'package:album/application/models/album/list_of.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class FetchAlbumListAfterSignInEffect extends Effect {
  FetchAlbumListAfterSignInEffect() {
    on<UserPrefetched>((event) async {
      final authRepository = Dependency.inject<AuthRepository>();

      final clientService = Dependency.inject<ClientService>();

      final accessToken = await authRepository.findAccessToken();

      final response = await clientService.get("album", headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response is! SuccessResponse) {
        return;
      }

      final model = ListOfAlbumModel.fromJson(response.body);

      dispatch(ListOfAlbumFound(model));
    });
  }
}
