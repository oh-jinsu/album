import 'package:album/presentation/components/album_list.dart';
import 'package:album/presentation/components/bottom_navigation.dart';
import 'package:album/presentation/components/home_app_bar.dart';
import 'package:album/presentation/layouts/home.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends Component {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return const HomeLayout(
      appBar: HomeAppBar(),
      body: AlbumListComponent(),
      bottomNavigationBar: BottomNavigationComponent(),
    );
  }
}
