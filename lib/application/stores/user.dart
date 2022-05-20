import 'package:album/application/events/user/found.dart';
import 'package:album/application/models/common/option.dart';
import 'package:album/application/models/user/user.dart';
import 'package:codux/codux.dart';

class UserStore extends Store<Option<UserModel>> {
  UserStore() : super(initialState: const None()) {
    on<UserFound>((current, event) {
      return Some(event.model);
    });
  }
}
