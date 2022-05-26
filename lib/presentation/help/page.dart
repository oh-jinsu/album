import 'package:album/presentation/common/widgets/menu.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class HelpPage extends Component {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            largeTitle: Text("도움말 및 문의"),
            border: Border(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CupertinoFormSection(
                  header: const Text("도움말"),
                  children: [
                    FormMenu(
                      onTap: () {},
                      prefix: const Text("아직 도움말이 없어요."),
                    ),
                  ],
                ),
                CupertinoFormSection(
                  header: const Text("문의"),
                  children: [
                    FormMenu(
                      onTap: () {
                        final form = Email(
                          recipients: ['developer@codersproduct.com'],
                        );

                        FlutterEmailSender.send(form);
                      },
                      prefix: const Text("개발자에게 직접 연락하기"),
                      child: const Icon(
                        CupertinoIcons.chevron_forward,
                        size: 20.0,
                        color: CupertinoColors.systemGrey3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
