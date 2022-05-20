import 'package:album/application/effects/photo/precache_added.dart';
import 'package:album/presentation/album/components/album_viewer.dart';
import 'package:album/presentation/album/components/bottom_navgiation.dart';
import 'package:album/presentation/album/widgets/app_bar.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AlbumPage extends Component {
  final String id;
  final String title;

  const AlbumPage({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useEffect(() => PrecacheAddedPhotoEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return CupertinoScaffold(
      body: CupertinoPageScaffold(
        child: Stack(
          children: [
            AlbumViewerComponent(id: id),
            AlbumAppBarComponent(title: title),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: AlbumBottomNavigationComponent(
                id: id,
              ),
            )
          ],
        ),
      ),
    );
  }
}
