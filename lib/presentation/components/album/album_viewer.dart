import 'package:album/application/effects/photo/fetch_list_of.dart';
import 'package:album/application/events/album/opened.dart';
import 'package:album/application/models/photo/list_of_photo.dart';
import 'package:album/application/stores/list_of_photo.dart';
import 'package:album/presentation/components/album/widgets/list.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';

class AlbumViewerComponent extends Component {
  final String id;

  const AlbumViewerComponent({
    super.key,
    required this.id,
  });

  @override
  void onCreated(BuildContext context) {
    useStore(() => ListOfPhotoStore());
    useEffect(() => FetchListOfPhotoEffect());

    super.onCreated(context);

    dispatch(AlbumOpened(id: id));
  }

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<ListOfPhotoStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as ListOfPhotoModel;

          return Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: PhotoStackWidget(
              albumId: id,
              items: data.items,
            ),
          );
        }

        return Container();
      },
    );
  }
}
