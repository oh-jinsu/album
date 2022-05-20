import 'package:album/application/events/app/failure_unexpected.dart';
import 'package:album/presentation/common/widgets/button.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class DialogEffect extends Effect {
  DialogEffect() {
    on<FailureUnexpected>((event) {
      showCupertinoDialog(
        context: requireContext(),
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("안내"),
            content: Text(event.message),
            actions: [
              Button(
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
