import 'package:album/application/models/album/friend.dart';

class AlbumModel {
  final String id;
  final String title;
  final String? coverImageUri;
  final int photoCount;
  final List<FriendModel> friends;
  final DateTime updatedAt;
  final DateTime createdAt;

  const AlbumModel({
    required this.id,
    required this.title,
    required this.coverImageUri,
    required this.photoCount,
    required this.friends,
    required this.updatedAt,
    required this.createdAt,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json["id"],
      title: json["title"],
      coverImageUri: json["cover_image_uri"],
      photoCount: json["photo_count"],
      friends:
          (json["users"] as List).map((e) => FriendModel.fromjson(e)).toList(),
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: json["created_at"],
    );
  }
}
