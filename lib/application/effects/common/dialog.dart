import 'package:album/application/events/app/dialog_requested.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class DialogEffect extends Effect {
  DialogEffect() {
    on<DialogRequested>((event) {
      showCupertinoDialog(
        context: requireContext(),
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("안내"),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(event.message),
            ),
            actions: [
              CupertinoButton(
                onPressed: () {
                  Navigator.of(requireContext()).pop();
                },
                child: const Text("확인"),
              )
            ],
          );
        },
      );
    });
  }
}
