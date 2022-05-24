import 'package:album/application/models/photo/photo.dart';
import 'package:album/presentation/album/widgets/floor.dart';
import 'package:flutter/cupertino.dart';

class PhotoStackWidget extends StatefulWidget {
  final void Function(String)? onTopItemChanged;
  final String albumId;
  final List<PhotoModel> items;

  const PhotoStackWidget({
    Key? key,
    this.onTopItemChanged,
    required this.albumId,
    required this.items,
  }) : super(key: key);

  @override
  State<PhotoStackWidget> createState() => _PhotoStackWidgetState();
}

class _PhotoStackWidgetState extends State<PhotoStackWidget> {
  List<PhotoModel> _items = [];

  List<int> _mustRemoveIndexs = [];

  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PhotoStackWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items.length < widget.items.length) {
      final updatedList = widget.items
          .where(
            (newone) =>
                oldWidget.items.every((oldone) => oldone.id != newone.id),
          )
          .toList()
          .reversed;

      setState(() {
        _items = [
          ...oldWidget.items.reversed,
          ...updatedList.toList().reversed,
        ];
      });
    }

    if (oldWidget.items.length > widget.items.length) {
      _mustRemoveIndexs = [];

      for (int i = 0; i < oldWidget.items.length; i++) {
        if (!widget.items.contains(oldWidget.items.reversed.toList()[i])) {
          _mustRemoveIndexs.add(i);
        }
      }

      setState(() {});
    }
  }

  void initialize() async {
    await Future.delayed(Duration.zero);

    setState(() {
      _items.addAll(widget.items.reversed);
    });
  }

  void onRemove(int index) async {
    if (_mustRemoveIndexs.contains(index)) {
      _mustRemoveIndexs.remove(index);
    }

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
    if (_items.isNotEmpty) {
      widget.onTopItemChanged?.call(_items.last.id);
    }

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
            mustRemove: _mustRemoveIndexs.contains(i),
          ),
      ],
    );
  }
}
