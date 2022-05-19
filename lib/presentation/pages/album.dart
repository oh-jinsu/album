import 'package:album/application/effects/photo/fetch_list_of.dart';
import 'package:album/application/events/album/opened.dart';
import 'package:album/application/models/photo/list_of_photo.dart';
import 'package:album/application/stores/list_of_photo.dart';
import 'package:album/presentation/widgets/album/list.dart';
import 'package:album/presentation/widgets/button.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';

class AlbumPage extends Component {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => ListOfPhotoStore());
    useEffect(() => FetchListOfPhotoEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    dispatch(AlbumOpened(id: arguments["id"]));

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          StreamBuilder(
            stream: find<ListOfPhotoStore>().stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as ListOfPhotoModel;

                return Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: AlbumListWidget(
                    albumId: arguments["id"],
                    items: data.items,
                  ),
                );
              }

              return Container();
            },
          ),
          CupertinoNavigationBar(
            middle: Text(
              arguments["title"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}
