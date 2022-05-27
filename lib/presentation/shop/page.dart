import 'package:album/application/events/shop/purchase_requested.dart';
import 'package:album/application/models/shop/item.dart';
import 'package:album/application/stores/film.dart';
import 'package:album/application/stores/shop.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class ShopPage extends Component {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: Border(),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 24.0),
              child: Text(
                "보유한 필름",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 12.0,
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
                  StreamBuilder(
                    stream: find<FilmStore>().stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data as int;

                        return RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(
                                text: "🌁 ",
                              ),
                              TextSpan(
                                text: "$data개",
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  color: CupertinoColors.activeBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return const CupertinoActivityIndicator();
                    },
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    "일요일마다 필름을 한 장씩 드리고 있어요!",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24.0, left: 24.0, bottom: 12.0),
              child: Text(
                "추가 구매",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder(
              stream: find<ShopStore>().stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<ShopItemModel>;

                  return CupertinoFormSection.insetGrouped(
                    // header: const Text("상품"),
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
                              Text("🌁 " + item.details.title),
                            ],
                          ),
                          child: CupertinoButton(
                            color: CupertinoColors.systemGroupedBackground,
                            minSize: 28.0,
                            borderRadius: BorderRadius.circular(32.0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
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
                            },
                          ),
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
