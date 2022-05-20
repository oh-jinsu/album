import 'package:flutter/material.dart';

class PhotoEditorLabel extends StatelessWidget {
  const PhotoEditorLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Text(
        "새로운 추억",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
