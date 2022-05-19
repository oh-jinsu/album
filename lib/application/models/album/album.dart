import 'package:album/application/models/album/friend.dart';
import 'package:album/application/models/common/argument.dart';

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
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  AlbumModel copy({
    New<String>? id,
    New<String>? title,
    New<String?>? coverImageUri,
    New<int>? photoCount,
    New<List<FriendModel>>? friends,
    New<DateTime>? updatedAt,
    New<DateTime>? createdAt,
  }) {
    return AlbumModel(
      id: id != null ? id.value : this.id,
      title: title != null ? title.value : this.title,
      coverImageUri:
          coverImageUri != null ? coverImageUri.value : this.coverImageUri,
      photoCount: photoCount != null ? photoCount.value : this.photoCount,
      friends: friends != null ? friends.value : this.friends,
      updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
      createdAt: createdAt != null ? createdAt.value : this.createdAt,
    );
  }
}
