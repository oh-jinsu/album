import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class SplashPage extends Component {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
