import 'dart:io';

import 'package:album/presentation/photo_form/widgets/picker_for_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoEditorDatePicker extends StatelessWidget {
  final void Function(DateTime value) onSubmitted;
  final bool enabled;
  final DateTime date;

  const PhotoEditorDatePicker({
    Key? key,
    required this.onSubmitted,
    this.enabled = true,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!enabled) {
          return;
        }

        if (Platform.isIOS) {
          final date = await showModalBottomSheet<DateTime>(
            context: context,
            builder: (context) => PickerForIos(
              date: this.date,
            ),
          );

          if (date == null) {
            return;
          }

          onSubmitted(date);
        } else {
          final date = await showDatePicker(
            context: context,
            initialDate: this.date,
            firstDate: DateTime.now().subtract(const Duration(days: 365 * 30)),
            lastDate: DateTime.now(),
          );

          if (date == null) {
            return;
          }

          onSubmitted(date);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("${date.year}.${date.month}.${date.day}"),
          const SizedBox(width: 6.0),
          Icon(
            CupertinoIcons.calendar,
            color: enabled ? null : CupertinoColors.inactiveGray,
          ),
        ],
      ),
    );
  }
}
