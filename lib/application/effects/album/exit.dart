import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/album/exit_requested.dart';
import 'package:album/application/events/album/exited.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class ExitAlbumEffect extends Effect with AuthEffectMixin {
  ExitAlbumEffect() {
    on<AlbumExitRequested>((event) async {
      final response = await withAuth(
        (client) => client.delete("album/${event.id}"),
      );

      if (response is! SuccessResponse) {
        return dispatch(const DialogRequested("예기치 못한 오류입니다."));
      }

      dispatch(AlbumExited(event.id));
    });
  }
}
