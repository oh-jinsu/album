class UserModel {
  final String id;
  final String name;
  final String? email;
  final String? avatarImageUri;
  final DateTime updatedAt;
  final DateTime createdAt;

  UserModel({
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
}
