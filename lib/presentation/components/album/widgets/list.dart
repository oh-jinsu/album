import 'package:album/application/models/photo/photo.dart';
import 'package:album/presentation/components/album/widgets/floor.dart';
import 'package:flutter/cupertino.dart';

class PhotoStackWidget extends StatefulWidget {
  final String albumId;
  final List<PhotoModel> items;

  const PhotoStackWidget({
    Key? key,
    required this.albumId,
    required this.items,
  }) : super(key: key);

  @override
  State<PhotoStackWidget> createState() => _PhotoStackWidgetState();
}

class _PhotoStackWidgetState extends State<PhotoStackWidget> {
  final List<PhotoModel> _items = [];

  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PhotoStackWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final updatedList = widget.items.where(
      (newone) => oldWidget.items.every((oldone) => oldone.id != newone.id),
    );

    setState(() {
      _items.addAll(updatedList);
    });
  }

  void initialize() async {
    await Future.delayed(Duration.zero);

    setState(() {
      _items.addAll(widget.items.reversed);
    });
  }

  void onRemove(int index) async {
    setState(() {
      _items.removeAt(index);
    });

    if (index != 0) {
      return;
    }

    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < _items.length; i++)
          AlbumFloorWidget(
            albumId: widget.albumId,
            index: i,
            imageUri: _items[i].publicImageUri,
            date: _items[i].date,
            description: _items[i].description,
            popDuration: 1000 ~/ _items.length,
            onRemove: onRemove,
          ),
      ],
    );
  }
}
