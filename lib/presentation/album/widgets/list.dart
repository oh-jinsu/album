import 'package:album/application/models/photo/photo.dart';
import 'package:album/presentation/album/widgets/floor.dart';
import 'package:flutter/cupertino.dart';

class PhotoStackWidget extends StatefulWidget {
  final bool hasMore;
  final void Function()? onScrollToTheEnd;
  final void Function(String?)? onTopItemChanged;
  final String albumId;
  final List<PhotoModel> items;

  const PhotoStackWidget({
    Key? key,
    this.onTopItemChanged,
    this.onScrollToTheEnd,
    required this.hasMore,
    required this.albumId,
    required this.items,
  }) : super(key: key);

  @override
  State<PhotoStackWidget> createState() => _PhotoStackWidgetState();
}

class _PhotoStackWidgetState extends State<PhotoStackWidget> {
  List<PhotoModel> _items = [];

  List<int> _mustRemoveIndexs = [];

  int skip = 0;

  int take = 5;

  @override
  void initState() {
    take = widget.items.length;

    Future.delayed(Duration.zero, next);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PhotoStackWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items.length < widget.items.length) {
      final updatedList = widget.items.where(
        (newone) => oldWidget.items.every((oldone) => oldone.id != newone.id),
      );

      if (_items.isEmpty) {
        setState(() {
          _items = [
            ...updatedList.toList().reversed,
          ];
        });
      } else {
        setState(() {
          _items = [
            ..._items,
            ...updatedList.toList().reversed,
          ];
        });
      }
    }

    if (oldWidget.items.length > widget.items.length) {
      _mustRemoveIndexs = [];

      for (int i = 0; i < _items.length; i++) {
        if (!widget.items.contains(_items[i])) {
          _mustRemoveIndexs.add(i);
        }
      }

      if (skip > 0) {
        skip -= _mustRemoveIndexs.length;
      }

      setState(() {});
    }
  }

  void next() {
    final items = widget.items.skip(skip).take(take).toList().reversed;

    setState(() => _items.addAll(items));
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

    if (widget.hasMore) {
      widget.onScrollToTheEnd?.call();
    } else {
      Future.delayed(Duration.zero, () {
        if (skip >= widget.items.length) {
          skip = 0;
        }

        next();

        skip += take;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isNotEmpty) {
      widget.onTopItemChanged?.call(_items.last.id);
    } else {
      widget.onTopItemChanged?.call(null);
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
