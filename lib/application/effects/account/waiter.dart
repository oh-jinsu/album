import 'package:album/application/events/auth/withdrew.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:codux/codux.dart';

class AccountWaiterEffect extends Effect {
  AccountWaiterEffect() {
    on<Withdrew>(((event) {
      dispatch(const Popped());
    }));
  }
}
