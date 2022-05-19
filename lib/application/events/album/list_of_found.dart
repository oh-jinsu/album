import 'package:album/application/models/album/list_of.dart';
import 'package:codux/codux.dart';

class ListOfAlbumFound implements Event {
  final ListOfAlbumModel model;

  const ListOfAlbumFound(this.model);
}
