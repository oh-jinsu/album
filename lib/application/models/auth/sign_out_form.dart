import 'package:album/application/models/common/argument.dart';

class SignOutFormModel {
  final bool isPending;

  const SignOutFormModel({required this.isPending});

  SignOutFormModel copy({
    New<bool>? isPending,
  }) {
    return SignOutFormModel(
      isPending: isPending != null ? isPending.value : this.isPending,
    );
  }
}
