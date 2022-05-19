import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/photo/photo.dart';

class ListOfPhotoModel {
  final String? next;
  final List<PhotoModel> items;

  const ListOfPhotoModel({
    required this.next,
    required this.items,
  });

  factory ListOfPhotoModel.fromJson(Map<String, dynamic> json) {
    return ListOfPhotoModel(
      next: json["next"],
      items: (json["items"] as List)
          .map(
            (e) => PhotoModel.fromJson(e),
          )
          .toList(),
    );
  }

  ListOfPhotoModel copy({
    New<String?>? next,
    New<List<PhotoModel>>? items,
  }) {
    return ListOfPhotoModel(
      next: next != null ? next.value : this.next,
      items: items != null ? items.value : this.items,
    );
  }
}
