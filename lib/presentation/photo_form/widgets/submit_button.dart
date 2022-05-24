import 'package:album/application/models/common/state.dart';
import 'package:album/presentation/common/widgets/button.dart';
import 'package:flutter/cupertino.dart';

class PhotoEditorSubmitButton extends StatelessWidget {
  final void Function() onPressed;
  final SubmitFormState state;

  const PhotoEditorSubmitButton({
    Key? key,
    required this.onPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = state == SubmitFormState.enabled
        ? CupertinoTheme.of(context).primaryColor
        : CupertinoColors.quaternarySystemFill;

    final foregroundColor = state == SubmitFormState.enabled
        ? CupertinoColors.white
        : CupertinoColors.systemGrey2;

    return Button(
      backgroundColor: backgroundColor,
      onPressed: () {
        if (state == SubmitFormState.enabled) {
          onPressed.call();
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: Center(
          child: state == SubmitFormState.pending
              ? CupertinoActivityIndicator(color: foregroundColor)
              : Text(
                  "추가하기",
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
        ),
      ),
    );
  }
}
