import 'dart:io';

import 'package:codux/codux.dart';

class SignUpFormSubmitted implements Event {
  final String provider;
  final String idToken;
  final File? avatar;
  final String name;
  final String email;

  const SignUpFormSubmitted({
    required this.provider,
    required this.idToken,
    required this.avatar,
    required this.name,
    required this.email,
  });
}
