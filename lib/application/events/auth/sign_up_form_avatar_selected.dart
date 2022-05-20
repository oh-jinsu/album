import 'dart:io';

import 'package:codux/codux.dart';

class SignUpFormAvatarSelected implements Event {
  final File file;

  const SignUpFormAvatarSelected(this.file);
}
