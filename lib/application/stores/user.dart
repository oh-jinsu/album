import 'package:album/application/events/auth/signed_out.dart';
import 'package:album/application/events/user/found_precached.dart';
import 'package:album/application/models/common/option.dart';
import 'package:album/application/models/user/user.dart';
import 'package:codux/codux.dart';

class UserStore extends Store<Option<UserModel>> {
  UserStore() : super(initialState: const None()) {
    on<FoundUserPrecached>((current, event) {
      return Some(event.model);
    });
    on<SignedOut>((current, event) {
      return const None();
    });
  }
}
