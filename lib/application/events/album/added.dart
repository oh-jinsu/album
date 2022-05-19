import 'package:album/application/models/album/album.dart';
import "package:codux/codux.dart";

class AlbumAdded implements Event {
  final AlbumModel model;

  const AlbumAdded(this.model);
}
