import 'package:album/application/events/album/added.dart';
import 'package:album/application/events/album/form_pending.dart';
import 'package:album/application/events/album/form_submitted.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/models/album/album.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SubmitAlbumFormEffect extends Effect {
  SubmitAlbumFormEffect() {
    on<AlbumFormSumitted>((event) async {
      final authRepoisotry = Dependency.find<AuthRepository>();

      final client = Dependency.find<Client>();

      dispatch(const AlbumFormPending());

      final accessToken = await authRepoisotry.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final response = await client.auth(accessToken).body({
        "title": event.title,
      }).post("album");

      if (response is! SuccessResponse) {
        return;
      }

      final album = AlbumModel.fromJson(response.body);

      dispatch(AlbumAdded(album));

      dispatch(const Popped());
    });
  }
}
