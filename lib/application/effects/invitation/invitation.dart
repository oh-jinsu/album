import 'dart:async';

import 'package:album/application/events/app/escorted.dart';
import 'package:album/infrastructure/services/jwt/jwt.dart';
import 'package:album/presentation/invitation/dialog.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class InvitationEffect extends Effect {
  StreamSubscription? subscription;

  InvitationEffect() {
    on<Escorted>((event) async {
      FirebaseDynamicLinks.instance.getInitialLink().then(_onLink);

      subscription = FirebaseDynamicLinks.instance.onLink.listen(_onLink);
    });
  }

  void _onLink(PendingDynamicLinkData? event) async {
    if (event == null) {
      return;
    }

    final link = event.link;

    if (link.path == "/invitation") {
      final jwtService = Dependency.find<JwtService>();

      final token = link.queryParameters["token"]!;

      final claim = await jwtService.extract(token);

      final albumTitle = claim["title"]!;

      final owner = claim["owner"]!;

      showCupertinoDialog(
        context: requireContext(),
        builder: (context) {
          return InvitationDialog(
            title: albumTitle,
            owner: owner,
            token: token,
          );
        },
      );
    }
  }

  @override
  void onDispose() {
    subscription?.cancel();

    super.onDispose();
  }
}
