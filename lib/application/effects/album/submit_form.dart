import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/album/added.dart';
import 'package:album/application/events/album/form_pending.dart';
import 'package:album/application/events/album/form_submitted.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/models/album/album.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class SubmitAlbumFormEffect extends Effect with AuthEffectMixin {
  SubmitAlbumFormEffect() {
    on<AlbumFormSumitted>((event) async {
      dispatch(const AlbumFormPending());

      final response = await withAuth(
        (client) => client.body({
          "title": event.title,
        }).post("album"),
      );

      if (response is! SuccessResponse) {
        return;
      }

      final album = AlbumModel.fromJson(response.body);

      dispatch(AlbumAdded(album));

      dispatch(const Popped());
    });
  }
}
