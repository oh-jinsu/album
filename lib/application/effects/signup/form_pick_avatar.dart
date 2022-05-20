import 'package:album/application/events/auth/sign_up_form_avatar_selected.dart';
import 'package:album/application/events/auth/sign_up_form_image_picker_tapped.dart';
import 'package:album/infrastructure/repositories/image.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

class PickSignUpFormAvatarEffect extends Effect {
  PickSignUpFormAvatarEffect() {
    on<SignUpFormAvatarPickerTapped>((event) async {
      final imageRepository = Dependency.find<ImageRepository>();

      final file = await imageRepository.pickFromGallery();

      if (file == null) {
        return;
      }

      dispatch(SignUpFormAvatarSelected(file));
    });
  }
}
