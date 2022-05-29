import 'package:album/application/events/shop/purchase_requested.dart';
import 'package:album/application/stores/film.dart';
import 'package:album/application/stores/shop.dart';
import 'package:album/presentation/shop/widgets/menu.dart';
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
                                text: "$data장",
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
            CupertinoFormSection.insetGrouped(
              children: [
                ShopMenu(
                  isPending: false,
                  onPressed: () => _onItemTap(context, 0),
                  label: "필름 10장",
                  price: "￦1,200",
                ),
                ShopMenu(
                  isPending: false,
                  onPressed: () => _onItemTap(context, 1),
                  label: "필름 25장",
                  price: "￦2,500",
                ),
                ShopMenu(
                  isPending: false,
                  onPressed: () => _onItemTap(context, 2),
                  label: "필름 50장",
                  price: "￦4,900",
                ),
                ShopMenu(
                  isPending: false,
                  onPressed: () => _onItemTap(context, 3),
                  label: "필름 100장",
                  price: "￦8,900",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTap(BuildContext context, int index) {
    try {
      final items = find<ShopStore>().stream.value;

      final item = items[index];

      if (item.isPending) {
        return;
      }

      dispatch(PurchaseRequested(item.details));
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("안내"),
            content: const Text("일시적인 오류입니다.\n나중에 다시 시도해 주세요."),
            actions: [
              CupertinoButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }
}
