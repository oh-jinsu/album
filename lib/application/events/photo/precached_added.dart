import 'package:album/application/models/photo/photo.dart';
import "package:codux/codux.dart";

class PrecachedPhotoAdded implements Event {
  final PhotoModel model;

  const PrecachedPhotoAdded(this.model);
}
