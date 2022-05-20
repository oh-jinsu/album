import 'package:album/application/events/user/found.dart';
import 'package:album/application/events/user/found_precached.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/infrastructure/services/precache/precache.dart';
import 'package:album/infrastructure/services/precache/resolution.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class PrecacheFoundUserEffect extends Effect {
  PrecacheFoundUserEffect() {
    on<UserFound>((event) async {
      final service = Dependency.inject<PrecacheService>();

      final result = await () async {
        final uri = event.model.avatarImageUri;

        if (uri == null) {
          return event.model;
        }

        final precachedUri = await service.fromNetwork(
          uri,
          resolution: Resolution.xhdpi,
        );

        return event.model.copy(avatarImageUri: New(precachedUri));
      }();

      dispatch(FoundUserPrecached(result));
    });
  }
}
