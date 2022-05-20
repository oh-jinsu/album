import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color? backgroundColor;

  const Button({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: backgroundColor,
      child: child,
      onPressed: onPressed,
      minSize: 0.0,
      padding: const EdgeInsets.all(0.0),
    );
  }
}
