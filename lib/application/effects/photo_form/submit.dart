import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/photo/added.dart';
import 'package:album/application/events/photo/pending.dart';
import 'package:album/application/events/photo/submitted.dart';
import 'package:album/application/models/photo/photo.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class SubmitPhotoFormEffect extends Effect with AuthEffectMixin {
  SubmitPhotoFormEffect() {
    on<PhotoFormSubmitted>((event) async {
      dispatch(const PhotoFormPending());

      final imageRes = await withAuth(
        (client) => client.file(event.file).post("util/image"),
      );

      if (imageRes is! SuccessResponse) {
        return;
      }

      final imageId = imageRes.body["id"];

      final response = await withAuth(
        (client) => client.body({
          "album_id": event.albumId,
          "image": imageId,
          "date": event.date.toIso8601String(),
          "description": event.description,
        }).post("photo"),
      );

      if (response is! SuccessResponse) {
        return;
      }

      final model = PhotoModel.fromJson(response.body);

      dispatch(PhotoAdded(model));

      dispatch(const Popped());
    });
  }
}
