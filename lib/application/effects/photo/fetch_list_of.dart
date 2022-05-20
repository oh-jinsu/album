import 'package:album/application/events/album/opened.dart';
import 'package:album/application/events/photo/list_of_found.dart';
import 'package:album/application/models/photo/list_of_photo.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class FetchListOfPhotoEffect extends Effect {
  FetchListOfPhotoEffect() {
    on<AlbumOpened>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final client = Dependency.find<Client>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final response =
          await client.auth(accessToken).get("photo?album_id=${event.id}");

      if (response is! SuccessResponse) {
        return;
      }

      final model = ListOfPhotoModel.fromJson(response.body);

      dispatch(ListOfPhotoFound(model));
    });
  }
}
