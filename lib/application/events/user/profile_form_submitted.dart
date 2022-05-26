import 'dart:io';

class ProfileFormSubmitted {
  final File? avatar;
  final String? name;
  final String? email;

  const ProfileFormSubmitted({
    required this.avatar,
    required this.name,
    required this.email,
  });
}
