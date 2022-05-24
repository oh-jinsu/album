import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/navigation/pushed.dart';
import 'package:album/application/stores/film.dart';
import 'package:album/presentation/common/widgets/button.dart';
import 'package:album/presentation/photo_form/widgets/bottom_inset.dart';
import 'package:album/presentation/photo_form/widgets/drawer.dart';
import 'package:album/presentation/photo_form/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:codux/codux.dart';

class PhotoEditorContainer extends Component {
  final _scrollController = ScrollController();

  final Widget child;

  PhotoEditorContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  void onDestroyed(BuildContext context) {
    _scrollController.dispose();

    super.onDestroyed(context);
  }

  @override
  Widget render(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 6.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PhotoEditorDrawer(),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                onPressed: () {
                  dispatch(const Popped());
                },
                child: const Text(
                  "취소",
                ),
              ),
              GestureDetector(
                onTap: () => dispatch(const Pushed("/shop")),
                child: StreamBuilder(
                  stream: find<FilmStore>().stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as int;

                      return Text(
                        "필름 $data개",
                        style: const TextStyle(
                          color: CupertinoColors.activeBlue,
                        ),
                      );
                    }

                    return const CupertinoActivityIndicator();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const PhotoEditorLabel(),
          const SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  child,
                  BottomInset(
                    onEnlarge: () {
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
