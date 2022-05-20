import 'package:flutter/material.dart';

class SignUpContainer extends StatelessWidget {
  final List<Widget> children;
  final Widget? bottom;

  const SignUpContainer({
    Key? key,
    required this.children,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: children),
              ),
            ),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: bottom!,
              ),
          ],
        ),
      ),
    );
  }
}
