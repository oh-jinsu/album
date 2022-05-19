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
}
