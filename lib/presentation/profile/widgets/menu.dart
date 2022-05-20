import 'package:flutter/cupertino.dart';

class ProfileMenu extends StatelessWidget {
  final void Function() onTap;
  final Widget prefix;
  final Widget? child;

  const ProfileMenu({
    Key? key,
    required this.onTap,
    required this.prefix,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CupertinoFormRow(
        padding: const EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
          left: 16.0,
          right: 12.0,
        ),
        prefix: prefix,
        child: child ?? Container(),
      ),
    );
  }
}
