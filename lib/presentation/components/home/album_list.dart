import 'package:album/application/events/navigation/pushed.dart';
import 'package:album/application/models/album/list_of.dart';
import 'package:album/application/stores/list_of_album.dart';
import 'package:album/presentation/components/home/widgets/album_tile.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class ListOfAlbumComponent extends Component {
  const ListOfAlbumComponent({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<ListOfAlbumStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as ListOfAlbumModel;

          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            childAspectRatio: 1 / 1.6,
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final item in data.items)
                AlbumTile(
                  onTap: () {
                    dispatch(
                      Pushed("/album", arguments: {
                        "id": item.id,
                        "title": item.title,
                      }),
                    );
                  },
                  item: item,
                )
            ],
          );
        }
        return Container();
      },
    );
  }
}
