import 'dart:io';

import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/common/state.dart';

class SignUpFormModel {
  final File? avatar;
  final String name;
  final String? nameMessage;
  final String email;
  final String? emailMessage;
  // final bool isServiceAgreed;
  final bool isPrivacyAgreed;
  final SubmitFormState state;

  const SignUpFormModel({
    required this.avatar,
    required this.name,
    required this.nameMessage,
    required this.email,
    required this.emailMessage,
    // required this.isServiceAgreed,
    required this.isPrivacyAgreed,
    required this.state,
  });

  SignUpFormModel copy({
    New<File?>? avatar,
    New<String>? name,
    New<String?>? nameMessage,
    New<String>? email,
    New<String?>? emailMessage,
    // New<bool>? isServiceAgreed,
    New<bool>? isPrivacyAgreed,
    New<SubmitFormState>? state,
  }) {
    return SignUpFormModel(
      avatar: avatar != null ? avatar.value : this.avatar,
      name: name != null ? name.value : this.name,
      nameMessage: nameMessage != null ? nameMessage.value : this.nameMessage,
      email: email != null ? email.value : this.email,
      emailMessage:
          emailMessage != null ? emailMessage.value : this.emailMessage,
      // isServiceAgreed: isServiceAgreed != null
      //     ? isServiceAgreed.value
      //     : this.isServiceAgreed,
      isPrivacyAgreed: isPrivacyAgreed != null
          ? isPrivacyAgreed.value
          : this.isPrivacyAgreed,
      state: state != null ? state.value : this.state,
    );
  }
}
