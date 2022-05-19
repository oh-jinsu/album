import 'package:flutter/material.dart';

class PhotoEditorDrawer extends StatelessWidget {
  const PhotoEditorDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36.0,
        height: 4.0,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
