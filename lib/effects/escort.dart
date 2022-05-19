import 'package:album/events/album/prefetched.dart';
import 'package:album/events/app/escorted.dart';
import 'package:album/events/navigation/replaced.dart';
import 'package:codux/codux.dart';

class EscortEffect extends Effect {
  EscortEffect() {
    on<ListOfAlbumPrefetched>((event) {
      dispatch(const Replaced("/home"));

      dispatch(const Escorted());
    });
  }
}
