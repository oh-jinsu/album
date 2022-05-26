import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/auth/signed_out.dart';
import 'package:album/application/events/auth/withdraw_requested.dart';
import 'package:album/application/events/auth/withdrew.dart';
import 'package:album/application/events/signin/guest_sign_in_requested.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class WithdrawEffect extends Effect with AuthEffectMixin {
  WithdrawEffect() {
    on<WithdrawRequested>((event) async {
      final authRepository = Dependency.find<AuthRepository>();

      final response = await withAuth((client) => client.delete("auth"));

      if (response is! SuccessResponse) {
        return dispatch(const DialogRequested("예기치 못한 오류입니다."));
      }

      dispatch(const Withdrew());

      await authRepository.deleteAccessToken();

      await authRepository.deleteRefreshToken();

      dispatch(const SignedOut());

      dispatch(const GuestSignInRequested());
    });
  }
}
