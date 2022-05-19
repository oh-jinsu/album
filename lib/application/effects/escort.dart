import 'package:album/application/events/album/prefetched.dart';
import 'package:album/application/events/app/escorted.dart';
import 'package:album/application/events/navigation/replaced.dart';
import 'package:codux/codux.dart';

class EscortEffect extends Effect {
  EscortEffect() {
    on<ListOfAlbumPrefetched>((event) {
      dispatch(const Replaced("/home"));

      dispatch(const Escorted());
    });
  }
}
