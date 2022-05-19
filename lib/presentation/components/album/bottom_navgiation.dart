import 'package:album/presentation/components/common/widgets/button.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';

class AlbumBottomNavigationComponent extends Component {
  const AlbumBottomNavigationComponent({super.key});

  @override
  Widget render(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      color: CupertinoColors.systemBackground,
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
              child: const Icon(
                CupertinoIcons.person_2,
              ),
              onPressed: () => {},
            ),
            Button(
                child: const Icon(
                  CupertinoIcons.plus_square,
                ),
                onPressed: () {}),
            Button(
              child: const Icon(
                CupertinoIcons.ellipsis_circle,
              ),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
