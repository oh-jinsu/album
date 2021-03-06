import 'package:album/application/effects/album/precache_added.dart';
import 'package:album/presentation/common/components/bottom_navigation.dart';
import 'package:album/presentation/home/components/album_list.dart';
import 'package:album/presentation/home/components/app_bar.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends Component {
  const HomePage({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useEffect(() => PrecacheAddedAlbumEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: const [
          Expanded(
            child: CustomScrollView(
              slivers: [
                HomeAppBarComponent(),
                SliverToBoxAdapter(
                  child: ListOfAlbumComponent(),
                )
              ],
            ),
          ),
          BottomNavigationComponent(currentIndex: 0),
        ],
      ),
    );
  }
}
