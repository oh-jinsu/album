import 'package:flutter/cupertino.dart';

class HomeLayout extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget bottomNavigationBar;

  const HomeLayout({
    Key? key,
    required this.appBar,
    required this.body,
    required this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                appBar,
                SliverToBoxAdapter(
                  child: body,
                )
              ],
            ),
          ),
          bottomNavigationBar,
        ],
      ),
    );
  }
}
