import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormMenu extends StatelessWidget {
  final void Function() onTap;
  final Widget prefix;
  final Widget? child;

  const FormMenu({
    Key? key,
    required this.onTap,
    required this.prefix,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
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
      ),
    );
  }
}
