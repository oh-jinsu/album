import 'dart:async';

import 'package:album/events/app/escorted.dart';
import 'package:album/events/navigation/pushed.dart';
import 'package:codux/codux.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class InvitationEffect extends Effect {
  StreamSubscription? subscription;

  InvitationEffect() {
    on<Escorted>((event) async {
      FirebaseDynamicLinks.instance
        ..getInitialLink().then(_onLink)
        ..onLink.listen(_onLink);
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
}
