import 'package:codux/codux.dart';

class ThirdPartyAccountFound implements Event {
  final String provider;
  final String idToken;
  final String? name;
  final String? email;

  const ThirdPartyAccountFound({
    required this.provider,
    required this.idToken,
    required this.name,
    required this.email,
  });
}
