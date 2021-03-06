import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/album/list_of_found.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/user/prefetched.dart';
import 'package:album/application/models/album/list_of.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class FetchAlbumListAfterSignInEffect extends Effect with AuthEffectMixin {
  FetchAlbumListAfterSignInEffect() {
    on<UserPrefetched>((event) async {
      final response = await withAuth((client) => client.get("album"));

      if (response is! SuccessResponse) {
        return dispatch(const DialogRequested("예기치 못한 오류입니다."));
      }

      final model = ListOfAlbumModel.fromJson(response.body);

      dispatch(ListOfAlbumFound(model));
    });
  }
}
