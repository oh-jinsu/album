import 'dart:io';

import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';

class ProfileFormModel {
  final File? avatar;
  final String? name;
  final String? nameMessage;
  final String? email;
  final String? emailMessage;
  final SubmitFormState state;

  const ProfileFormModel({
    required this.avatar,
    required this.name,
    required this.nameMessage,
    required this.email,
    required this.emailMessage,
    required this.state,
  });

  ProfileFormModel copy({
    New<File?>? avatar,
    New<String>? name,
    New<String?>? nameMessage,
    New<String>? email,
    New<String?>? emailMessage,
    New<SubmitFormState>? state,
  }) {
    return ProfileFormModel(
      avatar: avatar != null ? avatar.value : this.avatar,
      name: name != null ? name.value : this.name,
      nameMessage: nameMessage != null ? nameMessage.value : this.nameMessage,
      email: email != null ? email.value : this.email,
      emailMessage:
          emailMessage != null ? emailMessage.value : this.emailMessage,
      state: state != null ? state.value : this.state,
    );
  }
}
