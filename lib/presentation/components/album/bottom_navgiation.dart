import 'package:album/presentation/components/common/widgets/button.dart';
import 'package:album/presentation/modals/photo_form.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AlbumBottomNavigationComponent extends Component {
  final String id;

  const AlbumBottomNavigationComponent({
    super.key,
    required this.id,
  });

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
              onPressed: () {},
            ),
            Button(
              child: const Icon(
                CupertinoIcons.plus_square,
              ),
              onPressed: () {
                CupertinoScaffold.showCupertinoModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) => PhotoFormModal(
                    id: id,
                  ),
                );
              },
            ),
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
