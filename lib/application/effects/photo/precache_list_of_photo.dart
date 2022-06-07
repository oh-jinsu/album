import 'package:album/application/events/photo/precached_list_of_photo_found.dart';
import 'package:album/application/events/photo/list_of_found.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/infrastructure/services/precache/precache.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class PrecacheListOfPhotoEffect extends Effect {
  PrecacheListOfPhotoEffect() {
    on<ListOfPhotoFound>((event) async {
      final service = Dependency.find<PrecacheService>();

      final items = await Future.wait(event.model.items.map((item) async {
        final uri = await service.fromNetwork(item.publicImageUri);

        return item.copy(publicImageUri: New(uri));
      }));

      final model = event.model.copy(items: New(items));

      dispatch(PrecachedListOfPhotoFound(model));
    });
  }
}
