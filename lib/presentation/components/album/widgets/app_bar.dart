import 'package:flutter/cupertino.dart';

class AlbumAppBarComponent extends StatelessWidget {
  final String title;

  const AlbumAppBarComponent({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
