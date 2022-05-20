import 'package:album/application/events/photo/added.dart';
import 'package:album/application/events/photo/precached_added.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/infrastructure/services/precache/precache.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class PrecacheAddedPhotoEffect extends Effect {
  PrecacheAddedPhotoEffect() {
    on<PhotoAdded>((event) async {
      final service = Dependency.find<PrecacheService>();

      final uri = await service.fromNetwork(event.model.publicImageUri);

      final model = event.model.copy(publicImageUri: New(uri));

      dispatch(PrecachedPhotoAdded(model));
    });
  }
}
