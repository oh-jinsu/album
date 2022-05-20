import 'package:flutter/material.dart';

class BottomInset extends StatefulWidget {
  final void Function()? onEnlarge;

  const BottomInset({
    Key? key,
    this.onEnlarge,
  }) : super(key: key);

  @override
  State<BottomInset> createState() => _BottomInsetState();
}

class _BottomInsetState extends State<BottomInset>
    with TickerProviderStateMixin {
  late final _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..repeat();

  double _height = 0.0;

  @override
  void initState() {
    _animationController.addListener(() {
      final current = _height;

      final bottomInset = MediaQuery.of(context).viewInsets.bottom;

      if (current == bottomInset) {
        return;
      }

      setState(() {
        _height = bottomInset;
      });

      if (current < bottomInset) {
        widget.onEnlarge?.call();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}
