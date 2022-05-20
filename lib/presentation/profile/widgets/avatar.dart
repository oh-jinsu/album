import 'package:flutter/cupertino.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUri;

  const ProfileAvatar({
    Key? key,
    required this.imageUri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: SizedBox(
          width: 92.0,
          height: 92.0,
          child: imageUri == null
              ? Container(
                  color: CupertinoColors.systemGrey5,
                  child: const Icon(
                    CupertinoIcons.person_fill,
                    color: CupertinoColors.systemGrey2,
                    size: 50.0,
                  ),
                )
              : Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUri!),
                ),
        ),
      ),
    );
  }
}
