import 'package:album/presentation/components/album/album_viewer.dart';
import 'package:album/presentation/components/album/bottom_navgiation.dart';
import 'package:album/presentation/components/album/widgets/app_bar.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';

class AlbumPage extends Component {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          AlbumAppBarComponent(title: arguments["title"]),
          AlbumViewerComponent(id: arguments["id"]),
          const Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AlbumBottomNavigationComponent(),
          )
        ],
      ),
    );
  }
}
