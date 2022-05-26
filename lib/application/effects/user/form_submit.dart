import 'dart:io';

import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/user/profile_fom_failed.dart';
import 'package:album/application/events/user/profile_form_pending.dart';
import 'package:album/application/events/user/profile_form_submitted.dart';
import 'package:album/application/events/user/updated.dart';
import 'package:album/application/models/user/user.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class SubmitProfileFormEffect extends Effect with AuthEffectMixin {
  SubmitProfileFormEffect() {
    on<ProfileFormSubmitted>((event) async {
      dispatch(const ProfileFormPending());
      final body = [];

      if (event.avatar != null) {
        final avatarId = await _getAvatarIdIfExists(event.avatar);

        body.add({"op": "replace", "path": "/avatar_id", "value": avatarId});
      }

      if (event.name != null) {
        body.add({"op": "replace", "path": "/name", "value": event.name});
      }

      if (event.email != null) {
        if (event.email == "") {
          body.add({"op": "remove", "path": "/email"});
        } else {
          body.add({"op": "replace", "path": "/email", "value": event.email});
        }
      }

      final response = await withAuth(
        (client) => client.body(body).patch("user/me"),
      );

      if (response is! SuccessResponse) {
        dispatch(const ProfileFormFailed());

        return dispatch(const DialogRequested("예기치 못한 오류입니다."));
      }

      final model = UserModel.fromJson(response.body);

      dispatch(UserUpdated(model));
    });
  }

  Future<String?> _getAvatarIdIfExists(
    File? avatar,
  ) async {
    if (avatar == null) {
      return null;
    }

    final response = await withAuth(
      (client) => client.file(avatar).post("util/image"),
    );

    if (response is! SuccessResponse) {
      dispatch(const DialogRequested("예기치 못한 오류입니다."));

      return null;
    }

    return response.body["id"];
  }
}
