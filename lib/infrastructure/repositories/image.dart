import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageRepository {
  Future<File?> pickFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return null;
      }

      return File(image.path);
    } catch (e) {
      return null;
    }
  }

  Future<File?> pickFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        return null;
      }

      return File(image.path);
    } catch (e) {
      return null;
    }
  }
}
