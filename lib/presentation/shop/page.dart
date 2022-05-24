import 'package:album/application/events/shop/purchase_requested.dart';
import 'package:album/application/models/shop/item.dart';
import 'package:album/application/stores/film.dart';
import 'package:album/application/stores/shop.dart';
import 'package:album/presentation/shop/widgets/film.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class ShopPage extends Component {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text("구매"),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 32.0,
                  left: 20.0,
                  right: 20.0,
                ),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "가지고 있는 필름",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    StreamBuilder(
                      stream: find<FilmStore>().stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data as int;

                          return Row(
                            children: [
                              const ShopFilmImage(),
                              const SizedBox(width: 12.0),
                              Text(
                                "$data개",
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.activeBlue,
                                ),
                              ),
                            ],
                          );
                        }

                        return const CupertinoActivityIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream: find<ShopStore>().stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<ShopItemModel>;

                  return CupertinoFormSection.insetGrouped(
                    header: const Text("상품"),
                    children: [
                      for (final item in data)
                        CupertinoFormRow(
                          padding: const EdgeInsets.only(
                            top: 12.0,
                            bottom: 12.0,
                            left: 16.0,
                            right: 8.0,
                          ),
                          prefix: Row(
                            children: [
                              const ShopFilmImage(),
                              const SizedBox(width: 12.0),
                              Text(item.details.title),
                            ],
                          ),
                          child: CupertinoButton(
                              color: CupertinoColors.systemGroupedBackground,
                              minSize: 0.0,
                              borderRadius: BorderRadius.circular(32.0),
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                              child: SizedBox(
                                width: 84.0,
                                child: Center(
                                  child: item.isPending
                                      ? const CupertinoActivityIndicator(
                                          color: CupertinoColors.activeBlue,
                                        )
                                      : Text(
                                          item.details.price,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: CupertinoColors.activeBlue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                              onPressed: () {
                                if (item.isPending) {
                                  return;
                                }

                                dispatch(
                                  PurchaseRequested(item.details),
                                );
                              }),
                        )
                    ],
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
