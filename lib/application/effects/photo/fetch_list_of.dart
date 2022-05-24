import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/album/opened.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/photo/list_of_found.dart';
import 'package:album/application/models/photo/list_of_photo.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class FetchListOfPhotoEffect extends Effect with AuthEffectMixin {
  FetchListOfPhotoEffect() {
    on<AlbumOpened>((event) async {
      final response = await withAuth(
        (client) => client.get("photo?album_id=${event.id}"),
      );

      if (response is! SuccessResponse) {
        return dispatch(const DialogRequested("예기치 못한 오류입니다."));
      }

      final model = ListOfPhotoModel.fromJson(response.body);

      dispatch(ListOfPhotoFound(model));
    });
  }
}
