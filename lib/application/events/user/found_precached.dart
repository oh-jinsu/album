import 'package:album/application/models/user/user.dart';
import 'package:codux/codux.dart';

class FoundUserPrecached implements Event {
  final UserModel model;

  const FoundUserPrecached(this.model);
}
