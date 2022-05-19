import 'package:album/application/models/common/argument.dart';

class PhotoModel {
  final String id;
  final String userId;
  final String albumId;
  final String publicImageUri;
  final String? description;
  final DateTime date;
  final DateTime updatedAt;
  final DateTime createdAt;

  const PhotoModel({
    required this.id,
    required this.userId,
    required this.albumId,
    required this.publicImageUri,
    required this.description,
    required this.date,
    required this.updatedAt,
    required this.createdAt,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json["id"],
      userId: json["user_id"],
      albumId: json["album_id"],
      publicImageUri: json["public_image_uri"],
      description: json["description"],
      date: DateTime.parse(json["date"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  PhotoModel copy({
    New<String>? id,
    New<String>? userId,
    New<String>? albumId,
    New<String>? publicImageUri,
    New<String?>? description,
    New<DateTime>? date,
    New<DateTime>? updatedAt,
    New<DateTime>? createdAt,
  }) {
    return PhotoModel(
      id: id != null ? id.value : this.id,
      userId: userId != null ? userId.value : this.userId,
      albumId: albumId != null ? albumId.value : this.albumId,
      publicImageUri:
          publicImageUri != null ? publicImageUri.value : this.publicImageUri,
      description: description != null ? description.value : this.description,
      date: date != null ? date.value : this.date,
      updatedAt: updatedAt != null ? updatedAt.value : this.date,
      createdAt: createdAt != null ? createdAt.value : this.date,
    );
  }
}
