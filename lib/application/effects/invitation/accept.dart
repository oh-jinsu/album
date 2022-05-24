import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/album/added.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/invitation/accepted.dart';
import 'package:album/application/events/invitation/form_canceled.dart';
import 'package:album/application/events/invitation/form_pending.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/navigation/pushed.dart';
import 'package:album/application/models/album/album.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class AcceptInvitationEffect extends Effect with AuthEffectMixin {
  AcceptInvitationEffect() {
    on<InvitationAccepted>(
      (event) async {
        dispatch(const InvitationFormPending());

        final response = await withAuth(
          (client) => client.body({
            "invitation_token": event.token,
          }).post(
            "invitation/accept",
          ),
        );

        if (response is FailureResponse) {
          if (response.code == 104) {
            dispatch(const Pushed("/signin"));

            dispatch(const InvitationFormCanceled());
          }

          if (response.code == 4) {
            dispatch(const Popped());

            dispatch(const DialogRequested("이미 참여한 앨범이에요."));
          }

          return;
        }

        if (response is! SuccessResponse) {
          return dispatch(const DialogRequested("예기치 못한 오류입니다."));
        }

        final model = AlbumModel.fromJson(response.body);

        dispatch(AlbumAdded(model));

        dispatch(const Popped());
      },
    );
  }
}
