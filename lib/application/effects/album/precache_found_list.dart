import 'package:album/application/events/album/precached_list_of_found.dart';
import 'package:album/application/events/album/list_of_found.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/infrastructure/services/precache/precache.dart';
import 'package:album/infrastructure/services/precache/resolution.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class PrecacheFoundAlbumListEffect extends Effect {
  PrecacheFoundAlbumListEffect() {
    on<ListOfAlbumFound>((event) async {
      final service = Dependency.inject<PrecacheService>();

      final items = await Future.wait(
        event.model.items.map(
          (item) async {
            String? coverImageUri = item.coverImageUri;

            if (coverImageUri != null) {
              coverImageUri = await service.fromNetwork(
                coverImageUri,
                resolution: Resolution.xhdpi,
              );
            }

            final friends = await Future.wait(
              item.friends.map(
                (friend) async {
                  final avatarImageUri = friend.avatarImageUri;

                  if (avatarImageUri == null) {
                    return friend;
                  }

                  final cachedAvatarImageUri = await service.fromNetwork(
                    avatarImageUri,
                    resolution: Resolution.mdpi,
                  );

                  return friend.copy(avatarImageUri: New(cachedAvatarImageUri));
                },
              ),
            );

            return item.copy(
              coverImageUri: New(coverImageUri),
              friends: New(friends),
            );
          },
        ),
      );

      final result = event.model.copy(items: New(items));

      dispatch(PrecachedListOfAlbumFound(result));
    });
  }
}
