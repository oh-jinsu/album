import 'package:album/application/events/album/precached_added.dart';
import 'package:album/application/events/album/precached_list_of_found.dart';
import 'package:album/application/events/photo/precached_added.dart';
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
    on<PrecachedPhotoAdded>((current, event) {
      final items = current.state.items.map((item) {
        if (item.id != event.model.albumId) {
          return item;
        }

        return item.copy(
          coverImageUri: New(event.model.publicImageUri),
          photoCount: New(item.photoCount + 1),
        );
      }).toList();

      return current.state.copy(items: New(items));
    });
  }
}
