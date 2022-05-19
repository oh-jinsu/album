import 'package:album/application/models/photo/photo.dart';
import "package:codux/codux.dart";

class PhotoAdded implements Event {
  final PhotoModel model;

  const PhotoAdded(this.model);
}
