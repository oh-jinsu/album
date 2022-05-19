import 'package:album/application/models/common/argument.dart';

class FriendModel {
  final String id;
  final String name;
  final String? email;
  final String? avatarImageUri;
  final DateTime joinedAt;

  const FriendModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarImageUri,
    required this.joinedAt,
  });

  factory FriendModel.fromjson(Map<String, dynamic> json) {
    return FriendModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatarImageUri: json["avatar_image_uri"],
      joinedAt: DateTime.parse(json["joined_at"]),
    );
  }

  FriendModel copy({
    New<String>? id,
    New<String>? name,
    New<String?>? email,
    New<String?>? avatarImageUri,
    New<DateTime>? joinedAt,
  }) {
    return FriendModel(
      id: id != null ? id.value : this.id,
      name: name != null ? name.value : this.name,
      email: email != null ? email.value : this.email,
      avatarImageUri:
          avatarImageUri != null ? avatarImageUri.value : this.avatarImageUri,
      joinedAt: joinedAt != null ? joinedAt.value : this.joinedAt,
    );
  }
}
