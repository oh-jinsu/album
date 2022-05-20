import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/user/found_precached.dart';
import 'package:codux/codux.dart';

class SignInPageWaiterEffect extends Effect {
  SignInPageWaiterEffect() {
    on<FoundUserPrecached>((event) {
      dispatch(const Popped());
    });
  }
}
