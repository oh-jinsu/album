import 'package:album/models/album/album.dart';

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
}
