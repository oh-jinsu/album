import 'package:album/application/effects/album/exit.dart';
import 'package:album/application/effects/album/waiter.dart';
import 'package:album/application/events/album/exit_requested.dart';
import 'package:album/presentation/album/components/friend_list.dart';
import 'package:album/presentation/common/widgets/button.dart';
import 'package:album/presentation/photo_form/modal.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AlbumBottomNavigationComponent extends Component {
  final String id;

  const AlbumBottomNavigationComponent({
    super.key,
    required this.id,
  });

  @override
  void onCreated(BuildContext context) {
    useEffect(() => ExitAlbumEffect());
    useEffect(() => AlbumWaiterEffect());

    super.onCreated(context);
  }

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
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => FriendListModal(
                    albumId: id,
                  ),
                );
              },
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
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("현재 사진 삭제"),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            dispatch(AlbumExitRequested(id));

                            Navigator.of(context).pop();
                          },
                          child: const Text("앨범 나가기"),
                        )
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "취소",
                          style: TextStyle(
                            color: CupertinoColors.destructiveRed,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
