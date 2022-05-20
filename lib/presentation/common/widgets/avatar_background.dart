import 'package:flutter/cupertino.dart';

class AvatarBackground extends StatelessWidget {
  final double radius;

  const AvatarBackground({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      color: CupertinoColors.systemGrey5,
      child: Icon(
        CupertinoIcons.person_fill,
        color: CupertinoColors.systemGrey2,
        size: radius * 0.5,
      ),
    );
  }
}
