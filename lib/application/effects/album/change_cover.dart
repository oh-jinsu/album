import 'package:album/application/events/photo/added.dart';
import 'package:album/application/events/photo/album_cover_changed.dart';
import 'package:album/application/stores/list_of_photo.dart';
import 'package:album/infrastructure/services/precache/precache.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class ChangeAlbumCoverEffect extends Effect {
  ChangeAlbumCoverEffect() {
    on<PhotoAdded>((event) async {
      final photos = find<ListOfPhotoStore>().stream.value;

      if (photos.items.isNotEmpty) {
        if (photos.items.first.date.compareTo(event.model.date) > 0) {
          return;
        }
      }

      final service = Dependency.find<PrecacheService>();

      final uri = await service.fromNetwork(event.model.publicImageUri);

      dispatch(AlbumCoverChanged(
        albumId: event.model.albumId,
        coverImageUri: uri,
      ));
    });
  }
}
