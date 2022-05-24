import 'package:album/application/events/album/exited.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:codux/codux.dart';

class AlbumWaiterEffect extends Effect {
  AlbumWaiterEffect() {
    on<AlbumExited>((event) {
      dispatch(const Popped());
    });
  }
}
