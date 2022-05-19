import 'package:album/application/models/user/user.dart';
import "package:codux/codux.dart";

class UserFound implements Event {
  final UserModel model;

  const UserFound(this.model);
}
