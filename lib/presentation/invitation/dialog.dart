import 'package:album/application/effects/invitation/accept.dart';
import 'package:album/application/events/invitation/accepted.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/models/invitation/form.dart';
import 'package:album/application/stores/invitation_form.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class InvitationDialog extends Component {
  final String title;
  final String owner;
  final String token;

  const InvitationDialog({
    Key? key,
    required this.title,
    required this.owner,
    required this.token,
  }) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => InvitationFormStore());

    useEffect(() => AcceptInvitationEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<InvitationFormStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as InvitationFormModel;

          return CupertinoAlertDialog(
            title: Text(title),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("$owner님의 앨범 초대를 수락할까요?"),
            ),
            actions: [
              CupertinoButton(
                onPressed: () {
                  if (data.isPending) {
                    return;
                  }

                  dispatch(const Popped());
                },
                child: const Text(
                  "아니요",
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  if (data.isPending) {
                    return;
                  }

                  dispatch(InvitationAccepted(token: token));
                },
                child: data.isPending
                    ? const CupertinoActivityIndicator()
                    : const Text("그래요"),
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}
