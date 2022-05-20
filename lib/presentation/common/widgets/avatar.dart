import 'package:album/presentation/common/widgets/avatar_background.dart';
import 'package:flutter/cupertino.dart';

class Avatar extends StatelessWidget {
  final String? imageUri;
  final double radius;

  const Avatar({
    Key? key,
    required this.imageUri,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: SizedBox(
          child: imageUri == null
              ? AvatarBackground(radius: radius)
              : Image(
                  width: radius,
                  height: radius,
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUri!),
                ),
        ),
      ),
    );
  }
}
