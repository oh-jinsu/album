import 'package:flutter/cupertino.dart';

class AppRadioBox extends StatelessWidget {
  final bool enabled;

  const AppRadioBox({
    Key? key,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return const Icon(
        CupertinoIcons.check_mark_circled_solid,
        size: 20.0,
      );
    }

    return const Icon(
      CupertinoIcons.circle,
      color: CupertinoColors.inactiveGray,
      size: 20.0,
    );
  }
}
