import 'package:album/application/models/common/argument.dart';

class UserModel {
  final String id;
  final String name;
  final String? email;
  final String? avatarImageUri;
  final DateTime updatedAt;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarImageUri,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatarImageUri: json["avatar_image_uri"],
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  UserModel copy({
    New<String>? id,
    New<String>? name,
    New<String?>? email,
    New<String?>? avatarImageUri,
    New<DateTime>? updatedAt,
    New<DateTime>? createdAt,
  }) {
    return UserModel(
      id: id != null ? id.value : this.id,
      name: name != null ? name.value : this.name,
      email: email != null ? email.value : this.email,
      avatarImageUri:
          avatarImageUri != null ? avatarImageUri.value : this.avatarImageUri,
      updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
      createdAt: createdAt != null ? createdAt.value : this.createdAt,
    );
  }
}
