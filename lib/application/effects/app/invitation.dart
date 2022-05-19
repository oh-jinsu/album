import 'dart:async';

import 'package:album/application/events/app/escorted.dart';
import 'package:album/application/events/navigation/pushed.dart';
import 'package:codux/codux.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class InvitationEffect extends Effect {
  StreamSubscription? subscription;

  InvitationEffect() {
    on<Escorted>((event) async {
      FirebaseDynamicLinks.instance.getInitialLink().then(_onLink);

      subscription = FirebaseDynamicLinks.instance.onLink.listen(_onLink);
    });
  }

  void _onLink(PendingDynamicLinkData? event) {
    if (event == null) {
      return;
    }

    final link = event.link;

    if (link.path == "/invitation") {
      dispatch(Pushed("/invitation", arguments: {
        "token": link.queryParameters["token"],
      }));
    }
  }

  @override
  void onDispose() {
    subscription?.cancel();

    super.onDispose();
  }
}
