import 'dart:io';

import 'package:album/presentation/common/widgets/avatar_background.dart';
import 'package:flutter/cupertino.dart';

class SignUpAvatar extends StatelessWidget {
  final File? image;
  final void Function()? onTap;

  const SignUpAvatar({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: ClipOval(
            child: SizedBox(
          width: 92.0,
          height: 92.0,
          child: Stack(children: [
            Positioned.fill(
              child: image == null
                  ? const AvatarBackground(radius: 92.0)
                  : Image(
                      fit: BoxFit.cover,
                      image: FileImage(image!),
                    ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 18.0,
                color: CupertinoColors.black,
                child: const Center(
                  child: Text(
                    "편집",
                    style: TextStyle(
                      fontSize: 11.0,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
