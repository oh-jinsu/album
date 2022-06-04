import 'package:album/application/events/auth/sign_out_requested.dart';
import 'package:album/application/events/signin/guest_sign_in_requested.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';
import 'package:album/utilities/dependency.dart';

mixin AuthEffectMixin on Effect {
  Future<Response> withAuth(
    Future<Response> Function(Client client) request,
  ) async {
    final authRepository = Dependency.find<AuthRepository>();

    final client = Dependency.find<Client>();

    final accessToken = await authRepository.findAccessToken();

    if (accessToken == null) {
      dispatch(const GuestSignInRequested());

      await Future.delayed(const Duration(milliseconds: 1000));

      return withAuth(request);
    }

    try {
      final result = await request(client.auth(accessToken));

      if (result is FailureResponse) {
        switch (result.code) {
          case 102:
            final refreshToken = await authRepository.findRefreshToken();

            if (refreshToken == null) {
              dispatch(const SignOutRequested());

              return result;
            }

            final client = Dependency.find<Client>();

            final response = await client.body({
              "refresh_token": refreshToken,
            }).post("auth/refresh");

            if (response is! SuccessResponse) {
              dispatch(const SignOutRequested());

              return response;
            }

            final accessToken = response.body["access_token"];

            await authRepository.saveAccessToken(accessToken);

            return withAuth(request);
        }
      }

      return result;
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 5000));

      return withAuth(request);
    }
  }
}
