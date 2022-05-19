import 'package:album/application/models/photo/list_of_photo.dart';
import "package:codux/codux.dart";

class PrecachedListOfPhotoFound extends Event {
  final ListOfPhotoModel model;

  const PrecachedListOfPhotoFound(this.model);
}
