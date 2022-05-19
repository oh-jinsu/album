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
      final authRepository = Dependency.inject<AuthRepository>();

      final clientService = Dependency.inject<ClientService>();

      final accessToken = await authRepository.findAccessToken();

      final response =
          await clientService.get("photo?album_id=${event.id}", headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response is! SuccessResponse) {
        return;
      }

      final model = ListOfPhotoModel.fromJson(response.body);

      dispatch(ListOfPhotoFound(model));
    });
  }
}
