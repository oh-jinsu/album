import 'package:album/application/events/navigation/pushed.dart';
import 'package:album/application/stores/film.dart';
import 'package:album/presentation/common/widgets/button.dart';
import 'package:album/presentation/album_form/dialog.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';

class HomeAppBarComponent extends Component {
  const HomeAppBarComponent({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: const Text("앨범"),
      leading: Button(
        onPressed: () => showCupertinoDialog(
          context: context,
          builder: (context) => const AlbumFormDialog(),
        ),
        child: const Icon(CupertinoIcons.add),
      ),
      trailing: GestureDetector(
        onTap: () => dispatch(const Pushed("/shop")),
        child: StreamBuilder(
          stream: find<FilmStore>().stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as int;

              return Text(
                "필름 $data개",
                style: const TextStyle(
                  color: CupertinoColors.activeBlue,
                ),
              );
            }

            return const CupertinoActivityIndicator();
          },
        ),
      ),
    );
  }
}
