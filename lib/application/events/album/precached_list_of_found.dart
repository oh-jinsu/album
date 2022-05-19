import 'package:album/application/models/album/list_of.dart';
import 'package:codux/codux.dart';

class PrecachedListOfAlbumFound implements Event {
  final ListOfAlbumModel model;

  const PrecachedListOfAlbumFound(this.model);
}
