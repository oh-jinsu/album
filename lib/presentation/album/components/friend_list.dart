import 'package:album/application/effects/album/share.dart';
import 'package:album/application/events/album/share_requested.dart';
import 'package:album/application/models/album/list_of.dart';
import 'package:album/application/stores/list_of_album.dart';
import 'package:album/presentation/common/widgets/avatar.dart';
import 'package:album/presentation/common/widgets/button.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendListModal extends Component {
  final String albumId;

  const FriendListModal({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useEffect(() => ShareAlbumEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            trailing: Button(
              onPressed: () => dispatch(AlbumShareRequested(albumId)),
              child: const Icon(Icons.person_add_outlined),
            ),
          ),
          StreamBuilder(
            stream: find<ListOfAlbumStore>().stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as ListOfAlbumModel;

                final item =
                    data.items.firstWhere((item) => item.id == albumId);

                return Column(
                  children: [
                    for (int i = 0; i < item.friends.length * 2 - 1; i++)
                      if (i % 2 == 0) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                          child: Row(
                            children: [
                              Avatar(
                                imageUri: item.friends[i ~/ 2].avatarImageUri,
                                radius: 40.0,
                              ),
                              const SizedBox(width: 12.0),
                              Text(
                                item.friends[i ~/ 2].name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ] else
                        const Divider(height: 1.0)
                  ],
                );
              }

              return Container();
            },
          )
        ],
      ),
    );
  }
}
