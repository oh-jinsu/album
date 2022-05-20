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
      final authRepository = Dependency.find<AuthRepository>();

      final client = Dependency.find<Client>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final response = await client.auth(accessToken).get("album");

      if (response is! SuccessResponse) {
        return;
      }

      final model = ListOfAlbumModel.fromJson(response.body);

      dispatch(ListOfAlbumFound(model));
    });
  }
}
