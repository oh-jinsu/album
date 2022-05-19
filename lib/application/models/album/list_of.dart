import 'package:album/application/models/album/album.dart';
import 'package:album/application/models/common/argument.dart';

class ListOfAlbumModel {
  final String? next;
  final List<AlbumModel> items;

  const ListOfAlbumModel({
    required this.next,
    required this.items,
  });

  factory ListOfAlbumModel.fromJson(Map<String, dynamic> json) {
    return ListOfAlbumModel(
      next: json["next"],
      items:
          (json["items"] as List).map((e) => AlbumModel.fromJson(e)).toList(),
    );
  }

  ListOfAlbumModel copy({
    New<String?>? next,
    New<List<AlbumModel>>? items,
  }) {
    return ListOfAlbumModel(
      next: next != null ? next.value : this.next,
      items: items != null ? items.value : this.items,
    );
  }
}
