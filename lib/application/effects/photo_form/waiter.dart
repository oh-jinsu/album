import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/photo/added.dart';
import 'package:codux/codux.dart';

class PhotoFormWaiterEffect extends Effect {
  PhotoFormWaiterEffect() {
    on<PhotoAdded>((event) {
      dispatch(const Popped());
    });
  }
}
