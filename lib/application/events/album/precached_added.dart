import 'package:album/application/models/album/album.dart';
import "package:codux/codux.dart";

class PrecachedAlbumAdded implements Event {
  final AlbumModel model;

  const PrecachedAlbumAdded(this.model);
}
