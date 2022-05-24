import 'package:album/application/stores/film.dart';
import 'package:album/presentation/shop/widgets/film_stack.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class ShopPage extends Component {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("구매"),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ShopFilmImageStack(),
                    const SizedBox(width: 16.0),
                    SizedBox(
                      width: 108.0,
                      child: StreamBuilder(
                        stream: find<FilmStore>().stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data as int;

                            return Text(
                              "보유한 필름\n$data개",
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: CupertinoColors.activeBlue,
                              ),
                            );
                          }

                          return const CupertinoActivityIndicator();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
