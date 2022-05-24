import 'package:album/application/events/album/current_changed.dart';
import 'package:codux/codux.dart';

class AlbumCurrentStore extends Store<String> {
  AlbumCurrentStore() {
    on<AlbumCurrentChanged>((current, event) {
      return event.id;
    });
  }
}
