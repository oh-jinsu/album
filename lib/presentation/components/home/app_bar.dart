import 'package:album/presentation/components/common/widgets/button.dart';
import 'package:album/presentation/dialogs/add_album.dart';
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
          builder: (context) => const AddAlbumDialog(),
        ),
        child: const Icon(CupertinoIcons.add),
      ),
      trailing: const Text(
        "필름 10장",
        style: TextStyle(
          color: CupertinoColors.activeBlue,
        ),
      ),
    );
  }
}