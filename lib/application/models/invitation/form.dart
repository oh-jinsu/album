import 'package:album/application/models/common/argument.dart';

class InvitationFormModel {
  final bool isPending;

  const InvitationFormModel({required this.isPending});

  InvitationFormModel copy({
    New<bool>? isPending,
  }) {
    return InvitationFormModel(
      isPending: isPending != null ? isPending.value : this.isPending,
    );
  }
}
