import 'package:album/application/events/album/current_changed.dart';
import 'package:album/application/models/common/option.dart';
import 'package:codux/codux.dart';

class AlbumCurrentStore extends Store<Option<String>> {
  AlbumCurrentStore() : super(initialState: const None()) {
    on<AlbumCurrentChanged>((current, event) {
      return event.id;
    });
  }
}
