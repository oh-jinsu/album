import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class InvitationPage extends Component {
  const InvitationPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text("Invited!"),
      ),
    );
  }
}
