import 'package:album/presentation/widgets/button.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';

class HomeAppBar extends Component {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: const Text("앨범"),
      leading: Button(
        onPressed: () => showCupertinoDialog(
          context: context,
          builder: (context) => Container(),
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
