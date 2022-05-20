import 'dart:io';

import 'package:album/application/events/auth/sign_up_form_pending.dart';
import 'package:album/application/events/auth/sign_up_form_submitted.dart';
import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SubmitSignUpFormEffect extends Effect {
  SubmitSignUpFormEffect() {
    on<SignUpFormSubmitted>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final client = Dependency.find<Client>();

      dispatch(const SignUpFormPending());

      final guestAccessToken = await authRepository.findAccessToken();

      if (guestAccessToken == null) {
        return;
      }

      final authRes = await client.auth(guestAccessToken).body({
        "id_token": event.idToken,
      }).post("auth/signup?provider=${event.provider}");

      if (authRes is! SuccessResponse) {
        return;
      }

      final accessToken = authRes.body["access_token"];

      final refreshToken = authRes.body["refresh_token"];

      await authRepository.saveAccessToken(accessToken);

      await authRepository.saveRefreshToken(refreshToken);

      final avatar = await _getAvatarIdIfExists(accessToken, event.avatar);

      final userRes = await client.auth(accessToken).body({
        "avatar": avatar,
        "name": event.name,
        "email": event.email.isEmpty ? null : event.email,
      }).post("user/me");

      if (userRes is! SuccessResponse) {
        return;
      }

      dispatch(const SignedIn());
    });
  }

  static Future<String?> _getAvatarIdIfExists(
    String accessToken,
    File? avatar,
  ) async {
    if (avatar == null) {
      return null;
    }

    final client = Dependency.find<Client>();

    final response =
        await client.auth(accessToken).file(avatar).post("util/image");

    if (response is! SuccessResponse) {
      return null;
    }

    return response.body["id"];
  }
}
