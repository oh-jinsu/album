import 'package:album/presentation/common/widgets/button.dart';
import 'package:flutter/cupertino.dart';

class PickerForIos extends StatefulWidget {
  final DateTime date;

  const PickerForIos({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<PickerForIos> createState() => _PickerForIosState();
}

class _PickerForIosState extends State<PickerForIos> {
  DateTime? temporary;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          trailing: Button(
            onPressed: () => Navigator.of(context).pop(temporary),
            child: const Text("선택"),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: widget.date,
            maximumDate: DateTime.now(),
            onDateTimeChanged: (date) {
              temporary = date;
            },
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
