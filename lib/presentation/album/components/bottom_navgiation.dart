import 'package:album/application/effects/album/exit.dart';
import 'package:album/application/effects/album/waiter.dart';
import 'package:album/application/effects/photo/delete.dart';
import 'package:album/application/events/album/exit_requested.dart';
import 'package:album/application/events/photo/delete_requested.dart';
import 'package:album/application/models/common/option.dart';
import 'package:album/application/models/user/user.dart';
import 'package:album/application/stores/album_current.dart';
import 'package:album/application/stores/list_of_photo.dart';
import 'package:album/application/stores/user.dart';
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
    useEffect(() => DeletePhotoEffect());

    super.onCreated(context);
  }

  bool _canDeleteCurrent() {
    if (!find<AlbumCurrentStore>().stream.hasValue) {
      return false;
    }

    final user = find<UserStore>().stream.value;

    if (user is! Some<UserModel>) {
      return true;
    }

    final photos = find<ListOfPhotoStore>().stream.value;

    final photo = photos.items.firstWhere(
        (element) => element.id == find<AlbumCurrentStore>().stream.value);

    final owner = photo.userId;

    return owner == user.value.id;
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
                        if (_canDeleteCurrent())
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              final bool ok = await showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("경고"),
                                    content: const Text(
                                      "이 앨범에 저장된 사진을 지웁니다.\n계속하시겠습니까?",
                                    ),
                                    actions: [
                                      CupertinoButton(
                                        child: const Text("취소"),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: const Text("확인"),
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );

                              if (!ok) {
                                return;
                              }

                              dispatch(
                                PhotoDeleteRequested(
                                  id: find<AlbumCurrentStore>().stream.value,
                                  albumId: id,
                                ),
                              );

                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "현재 사진 삭제",
                              style: TextStyle(
                                color: CupertinoColors.destructiveRed,
                              ),
                            ),
                          ),
                        CupertinoActionSheetAction(
                          onPressed: () async {
                            final bool ok = await showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("경고"),
                                  content: const Text(
                                    "더 이상 앨범을 볼 수 없게 됩니다.\n앨범을 나가시겠습니까?",
                                  ),
                                  actions: [
                                    CupertinoButton(
                                      child: const Text("취소"),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                    ),
                                    CupertinoButton(
                                      child: const Text("확인"),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                    )
                                  ],
                                );
                              },
                            );

                            if (!ok) {
                              return;
                            }

                            dispatch(AlbumExitRequested(id));

                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "앨범 나가기",
                            style: TextStyle(
                              color: CupertinoColors.destructiveRed,
                            ),
                          ),
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
