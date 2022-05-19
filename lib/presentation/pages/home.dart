import 'package:album/presentation/components/common/bottom_navigation.dart';
import 'package:album/presentation/components/home/album_list.dart';
import 'package:album/presentation/components/home/app_bar.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends Component {
  const HomePage({Key? key}) : super(key: key);

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
          BottomNavigationComponent(),
        ],
      ),
    );
  }
}
