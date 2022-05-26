import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/user/update_precached.dart';
import 'package:codux/codux.dart';

class ProfileWaiterEffect extends Effect {
  ProfileWaiterEffect() {
    on<UpdatedUserPrecached>((event) {
      dispatch(const Popped());
    });
  }
}
