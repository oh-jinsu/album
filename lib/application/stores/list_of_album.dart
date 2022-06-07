import 'package:album/application/events/album/cover_deleted.dart';
import 'package:album/application/events/album/exited.dart';
import 'package:album/application/events/album/precached_added.dart';
import 'package:album/application/events/album/precached_list_of_found.dart';
import 'package:album/application/events/photo/added.dart';
import 'package:album/application/events/photo/album_cover_changed.dart';
import 'package:album/application/events/photo/deleted.dart';
import 'package:album/application/events/user/update_precached.dart';
import 'package:album/application/models/album/list_of.dart';
import 'package:album/application/models/common/argument.dart';
import "package:codux/codux.dart";

class ListOfAlbumStore extends Store<ListOfAlbumModel> {
  ListOfAlbumStore() {
    on<PrecachedListOfAlbumFound>((current, event) {
      return event.model;
    });
    on<PrecachedAlbumAdded>((current, event) {
      if (current.hasState) {
        return current.state.copy(
          items: New(
            [
              event.model,
              ...current.state.items,
            ],
          ),
        );
      }

      return ListOfAlbumModel(next: null, items: [event.model]);
    });
    on<PhotoAdded>((current, event) {
      final items = current.state.items.map((item) {
        if (item.id != event.model.albumId) {
          return item;
        }

        return item.copy(
          photoCount: New(item.photoCount + 1),
        );
      }).toList();

      return current.state.copy(items: New(items));
    });
    on<AlbumCoverChanged>((current, event) {
      final items = current.state.items.map((item) {
        if (item.id != event.albumId) {
          return item;
        }

        return item.copy(
          coverImageUri: New(event.coverImageUri),
        );
      }).toList();

      return current.state.copy(items: New(items));
    });
    on<AlbumExited>((current, event) {
      return current.state.copy(
        items: New(
          current.state.items
              .where((element) => element.id != event.id)
              .toList(),
        ),
      );
    });
    on<CoverDeleted>((current, event) {
      return current.state.copy(
        items: New(current.state.items.map((e) {
          if (e.id != event.albumId) {
            return e;
          }

          return e.copy(coverImageUri: New(event.newCoverImageUri));
        }).toList()),
      );
    });
    on<PhotoDeleted>((current, event) {
      return current.state.copy(
        items: New(current.state.items.map((e) {
          if (e.id != event.albumId) {
            return e;
          }

          return e.copy(photoCount: New(e.photoCount - 1));
        }).toList()),
      );
    });
    on<UpdatedUserPrecached>((current, event) {
      return current.state.copy(
        items: New(current.state.items.map((item) {
          return item.copy(
              friends: New(item.friends.map((friend) {
            if (friend.id != event.model.id) {
              return friend;
            }

            return friend.copy(avatarImageUri: New(event.model.avatarImageUri));
          }).toList()));
        }).toList()),
      );
    });
  }
}
