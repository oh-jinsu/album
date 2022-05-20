import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/user/found_precached.dart';
import 'package:codux/codux.dart';

class SignUpPageWaiterEffect extends Effect {
  SignUpPageWaiterEffect() {
    on<FoundUserPrecached>((event) {
      dispatch(const Popped());
    });
  }
}
