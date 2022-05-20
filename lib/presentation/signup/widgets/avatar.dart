import 'dart:io';

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
          width: 100.0,
          height: 100.0,
          child: Stack(children: [
            Positioned.fill(
              child: image == null
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
                      image: FileImage(image!),
                    ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 20.0,
                color: CupertinoColors.black,
                child: const Center(
                  child: Text(
                    "편집",
                    style: TextStyle(
                      fontSize: 12.0,
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
