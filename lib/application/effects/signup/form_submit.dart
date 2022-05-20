import 'dart:io';

import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/failure_unexpected.dart';
import 'package:album/application/events/auth/sign_up_form_pending.dart';
import 'package:album/application/events/auth/sign_up_form_submitted.dart';
import 'package:album/application/events/auth/signed_in.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class SubmitSignUpFormEffect extends Effect with AuthEffectMixin {
  SubmitSignUpFormEffect() {
    on<SignUpFormSubmitted>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      dispatch(const SignUpFormPending());

      final authRes = await withAuth(
        (client) => client.body({
          "id_token": event.idToken,
        }).post("auth/signup?provider=${event.provider}"),
      );

      if (authRes is! SuccessResponse) {
        return dispatch(FailureUnexpected(
          authRes is FailureResponse ? authRes.message : "예기치 못한 오류입니다.",
        ));
      }

      final accessToken = authRes.body["access_token"];

      final refreshToken = authRes.body["refresh_token"];

      await authRepository.saveAccessToken(accessToken);

      await authRepository.saveRefreshToken(refreshToken);

      final avatar = await _getAvatarIdIfExists(accessToken, event.avatar);

      final userRes = await withAuth(
        (client) => client.body({
          "avatar": avatar,
          "name": event.name,
          "email": event.email.isEmpty ? null : event.email,
        }).post("user/me"),
      );

      if (userRes is! SuccessResponse) {
        return dispatch(FailureUnexpected(
          userRes is FailureResponse ? userRes.message : "예기치 못한 오류입니다.",
        ));
      }

      dispatch(const SignedIn());
    });
  }

  Future<String?> _getAvatarIdIfExists(
    String accessToken,
    File? avatar,
  ) async {
    if (avatar == null) {
      return null;
    }

    final response = await withAuth(
      (client) => client.file(avatar).post("util/image"),
    );

    if (response is! SuccessResponse) {
      dispatch(const FailureUnexpected("예기치 못한 오류입니다."));

      return null;
    }

    return response.body["id"];
  }
}
