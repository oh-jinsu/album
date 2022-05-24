import 'dart:io';

class SignUpFormSubmitted {
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
