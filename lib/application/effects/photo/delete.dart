import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/album/cover_deleted.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/photo/delete_requested.dart';
import 'package:album/application/events/photo/deleted.dart';
import 'package:album/application/stores/list_of_photo.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class DeletePhotoEffect extends Effect with AuthEffectMixin {
  DeletePhotoEffect() {
    on<PhotoDeleteRequested>((event) async {
      final response = await withAuth(
        (client) => client.delete("photo/${event.id}"),
      );

      if (response is! SuccessResponse) {
        return dispatch(const DialogRequested("예기치 못한 오류입니다."));
      }

      final photos = find<ListOfPhotoStore>().stream.value;

      if (photos.items.first.id == event.id) {
        final newCoverImageUri = () {
          if (photos.items.length >= 2) {
            return photos.items[1].publicImageUri;
          }

          return null;
        }();

        dispatch(CoverDeleted(
          albumId: event.albumId,
          newCoverImageUri: newCoverImageUri,
        ));
      }

      dispatch(PhotoDeleted(id: event.id, albumId: event.albumId));
    });
  }
}
