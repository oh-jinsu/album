import 'package:album/application/events/photo/picker_tapped.dart';
import 'package:album/application/events/photo/file_selected.dart';
import 'package:album/infrastructure/repositories/image.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class PickImageEffect extends Effect {
  PickImageEffect() {
    on<PhotoFormImagePickerTapped>((event) async {
      final imageRepository = Dependency.find<ImageRepository>();

      final file = await imageRepository.pickFromGallery();

      if (file == null) {
        return;
      }

      dispatch(PhotoFormFileSelected(file));
    });
  }
}
