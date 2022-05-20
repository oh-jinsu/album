import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumTileAvatar extends StatelessWidget {
  final String? networkImageUri;

  const AlbumTileAvatar({
    Key? key,
    required this.networkImageUri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 9.0,
      backgroundColor: networkImageUri == null
          ? CupertinoColors.secondarySystemBackground
          : Colors.transparent,
      backgroundImage: networkImageUri != null
          ? NetworkImage(
              networkImageUri!,
            )
          : null,
      child: networkImageUri == null
          ? const Icon(
              CupertinoIcons.person_fill,
              color: CupertinoColors.systemGrey,
              size: 12.0,
            )
          : null,
    );
  }
}
