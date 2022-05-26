import 'package:album/application/effects/account/waiter.dart';
import 'package:album/application/effects/account/withdraw.dart';
import 'package:album/application/events/auth/withdraw_requested.dart';
import 'package:album/presentation/common/widgets/menu.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class AccountPage extends Component {
  const AccountPage({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useEffect(() => WithdrawEffect());
    useEffect(() => AccountWaiterEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text("계정"),
        border: Border(),
        backgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            CupertinoFormSection(
              margin: const EdgeInsets.only(bottom: 8.0),
              footer: const Text("신중히 선택하세요."),
              children: [
                FormMenu(
                  onTap: () async {
                    final bool ok = await showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("경고"),
                          content: const Text(
                            "계정을 삭제합니다.\n이 작업은 되돌릴 수 없습니다.\n계속하시겠습니까?",
                          ),
                          actions: [
                            CupertinoButton(
                              child: const Text(
                                "취소",
                                style: TextStyle(
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                            CupertinoButton(
                              child: const Text(
                                "확인",
                                style: TextStyle(
                                  color: CupertinoColors.destructiveRed,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            )
                          ],
                        );
                      },
                    );

                    if (!ok) {
                      return;
                    }

                    dispatch(const WithdrawRequested());
                  },
                  prefix: const Text(
                    "계정 삭제",
                    style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
