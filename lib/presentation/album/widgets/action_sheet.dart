import 'package:flutter/cupertino.dart';

class AlbumActionSheetWidget extends StatelessWidget {
  const AlbumActionSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {},
          child: const Text("현재 사진 수정"),
        ),
        CupertinoActionSheetAction(
          onPressed: () {},
          child: const Text("앨범 인화 주문"),
        ),
        CupertinoActionSheetAction(
          onPressed: () {},
          child: const Text(
            "앨범 삭제",
            style: TextStyle(
              color: CupertinoColors.systemRed,
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("취소"),
      ),
    );
  }
}
