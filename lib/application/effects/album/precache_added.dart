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
      final precacheService = Dependency.inject<PrecacheService>();

      final friends = await Future.wait(event.model.friends.map(
        (friend) async {
          final uri = friend.avatarImageUri;

          if (uri == null) {
            return friend;
          }

          final cachedUri = await precacheService.fromNetwork(
            uri,
            resolution: Resolution.mdpi,
          );

          return friend.copy(avatarImageUri: New(cachedUri));
        },
      ));

      final model = event.model.copy(
        friends: New(friends),
      );

      dispatch(PrecachedAlbumAdded(model));
    });
  }
}
