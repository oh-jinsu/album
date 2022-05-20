import 'package:album/application/models/common/argument.dart';

class SignInFormModel {
  final bool isPending;

  const SignInFormModel({required this.isPending});

  SignInFormModel copy({
    New<bool>? isPending,
  }) {
    return SignInFormModel(
      isPending: isPending != null ? isPending.value : this.isPending,
    );
  }
}
