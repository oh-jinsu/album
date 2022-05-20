import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/photo/added.dart';
import 'package:album/application/events/photo/pending.dart';
import 'package:album/application/events/photo/submitted.dart';
import 'package:album/application/models/photo/photo.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SubmitPhotoFormEffect extends Effect {
  SubmitPhotoFormEffect() {
    on<PhotoFormSubmitted>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final client = Dependency.find<Client>();

      dispatch(const PhotoFormPending());

      final accessToken = await authRepository.findAccessToken();

      if (accessToken == null) {
        return;
      }

      final imageRes =
          await client.auth(accessToken).file(event.file).post("util/image");

      if (imageRes is! SuccessResponse) {
        return;
      }

      final imageId = imageRes.body["id"];

      final response = await client.auth(accessToken).body({
        "album_id": event.albumId,
        "image": imageId,
        "date": event.date.toIso8601String(),
        "description": event.description,
      }).post("photo");

      if (response is! SuccessResponse) {
        return;
      }

      final model = PhotoModel.fromJson(response.body);

      dispatch(PhotoAdded(model));

      dispatch(const Popped());
    });
  }
}
