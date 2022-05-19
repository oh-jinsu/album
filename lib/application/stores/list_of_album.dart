import 'package:album/application/events/album/added.dart';
import 'package:album/application/events/album/list_of_found.dart';
import 'package:album/application/events/photo/added.dart';
import 'package:album/application/models/album/list_of.dart';
import 'package:album/application/models/common/argument.dart';
import "package:codux/codux.dart";

class ListOfAlbumStore extends Store<ListOfAlbumModel> {
  ListOfAlbumStore() {
    on<ListOfAlbumFound>((current, event) {
      return event.model;
    });
    on<AlbumAdded>((current, event) {
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

        return item.copy(coverImageUri: New(event.model.publicImageUri));
      }).toList();

      return current.state.copy(items: New(items));
    });
  }
}
