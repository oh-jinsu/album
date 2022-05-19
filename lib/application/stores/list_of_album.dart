import 'package:album/application/events/album/list_of_found.dart';
import 'package:album/application/models/album/list_of.dart';
import "package:codux/codux.dart";

class ListOfAlbumStore extends Store<ListOfAlbumModel> {
  ListOfAlbumStore() {
    on<ListOfAlbumFound>((current, event) {
      return event.model;
    });
  }
}
