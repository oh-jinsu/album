import 'package:album/application/models/photo/list_of_photo.dart';
import "package:codux/codux.dart";

class ListOfPhotoFound implements Event {
  final ListOfPhotoModel model;

  const ListOfPhotoFound(this.model);
}
