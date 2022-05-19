import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumFriendsWidget extends StatelessWidget {
  final List<String> avatarUris;
  final List<String> usernames;

  const AlbumFriendsWidget({
    Key? key,
    required this.avatarUris,
    required this.usernames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              bottom: 8.0,
              right: 16.0,
            ),
            child: Row(
              children: [
                const Text(
                  "구성원",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  minSize: 0.0,
                  padding: const EdgeInsets.all(0.0),
                  child: const Icon(CupertinoIcons.add),
                  onPressed: () {},
                )
              ],
            ),
          ),
          for (int i = 0; i < usernames.length * 2 - 1; i++)
            if (i % 2 == 0)
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(avatarUris[i ~/ 2]),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(usernames[i ~/ 2]),
              )
            else
              const Divider(),
        ],
      ),
    );
  }
}
