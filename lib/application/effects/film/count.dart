import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/failure_unexpected.dart';
import 'package:album/application/events/film/counted.dart';
import 'package:album/application/events/user/prefetched.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class CountFilmEffect extends Effect with AuthEffectMixin {
  CountFilmEffect() {
    on<UserPrefetched>((event) async {
      final response = await withAuth((client) => client.get("film/count"));

      if (response is! SuccessResponse) {
        return dispatch(const FailureUnexpected("예기치 못한 오류입니다."));
      }

      final value = response.body["count"];

      dispatch(FilmCounted(value));
    });
  }
}
