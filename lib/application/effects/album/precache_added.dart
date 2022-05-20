import 'package:album/application/events/album/added.dart';
import 'package:album/application/events/album/precached_added.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/infrastructure/services/precache/precache.dart';
import 'package:album/infrastructure/services/precache/resolution.dart';
import 'package:album/utilities/dependency.dart';
import "package:codux/codux.dart";

class PrecacheAddedAlbumEffect extends Effect {
  PrecacheAddedAlbumEffect() {
    on<AlbumAdded>((event) async {
      final service = Dependency.find<PrecacheService>();

      final coverImageUri = event.model.coverImageUri;

      final coverPrecachedModel = coverImageUri == null
          ? event.model
          : event.model.copy(
              coverImageUri: New(await service.fromNetwork(
              coverImageUri,
              resolution: Resolution.xhdpi,
            )));

      final friends = await Future.wait(event.model.friends.map(
        (friend) async {
          final uri = friend.avatarImageUri;

          if (uri == null) {
            return friend;
          }

          final cachedUri = await service.fromNetwork(
            uri,
            resolution: Resolution.mdpi,
          );

          return friend.copy(avatarImageUri: New(cachedUri));
        },
      ));

      final model = coverPrecachedModel.copy(
        friends: New(friends),
      );

      dispatch(PrecachedAlbumAdded(model));
    });
  }
}
