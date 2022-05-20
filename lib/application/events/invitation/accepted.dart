import 'package:codux/codux.dart';

class InvitationAccepted implements Event {
  final String token;

  const InvitationAccepted({required this.token});
}
