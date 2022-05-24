import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/album/share_requested.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/navigation/replaced.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/infrastructure/services/share/share.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class ShareAlbumEffect extends Effect with AuthEffectMixin {
  ShareAlbumEffect() {
    on<AlbumShareRequested>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final accessToken = await authRepository.findAccessToken();

      if (accessToken != null) {
        dispatch(const Popped());

        dispatch(const Replaced("/signin"));

        return;
      }

      final response = await withAuth(
        (client) => client.get("invitation?album_id=${event.id}"),
      );

      if (response is! SuccessResponse) {
        return dispatch(const DialogRequested("예기치 못한 오류입니다."));
      }

      final url = response.body["url"];

      final shareService = Dependency.find<ShareService>();

      await shareService.share(
        "링크를 누르면 초대받은 앨범으로 이동해요.\n\n$url",
        subject: "추억보관함",
      );
    });
  }
}
