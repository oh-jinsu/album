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
      final authRepository = Dependency.inject<AuthRepository>();

      final clientService = Dependency.inject<ClientService>();

      dispatch(const SignUpFormPending());

      final guestAccessToken = await authRepository.findAccessToken();

      final authRes = await clientService.post(
        "auth/signup?provider=${event.provider}",
        headers: {
          "Authorization": "Bearer $guestAccessToken",
        },
        body: {
          "id_token": event.idToken,
        },
      );

      if (authRes is! SuccessResponse) {
        return;
      }

      final accessToken = authRes.body["access_token"];

      final refreshToken = authRes.body["refresh_token"];

      await authRepository.saveAccessToken(accessToken);

      await authRepository.saveRefreshToken(refreshToken);

      final avatar = await _getAvatarIdIfExists(accessToken, event.avatar);

      final userRes = await clientService.post(
        "user/me",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
        body: {
          "avatar": avatar,
          "name": event.name,
          "email": event.email.isEmpty ? null : event.email,
        },
      );

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

    final clientService = Dependency.inject<ClientService>();

    final response = await clientService.postMultipart(
      "util/image",
      avatar,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response is! SuccessResponse) {
      return null;
    }

    return response.body["id"];
  }
}
