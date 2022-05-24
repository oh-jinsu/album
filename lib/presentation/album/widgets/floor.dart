import 'dart:math';

import 'package:flutter/material.dart';

class AlbumFloorWidget extends StatefulWidget {
  final String albumId;
  final int index;
  final String imageUri;
  final String? description;
  final DateTime date;
  final int popDuration;
  final bool mustRemove;
  final void Function(int) onRemove;

  const AlbumFloorWidget({
    Key? key,
    required this.albumId,
    required this.index,
    required this.imageUri,
    this.description,
    required this.date,
    required this.popDuration,
    required this.onRemove,
    this.mustRemove = false,
  }) : super(key: key);

  @override
  State<AlbumFloorWidget> createState() => _AlbumFloorWidgetState();
}

class _AlbumFloorWidgetState extends State<AlbumFloorWidget>
    with TickerProviderStateMixin {
  static const _biasDepthsY = 2;
  static const _biasDepthsZ = 1;

  static const _biasPositionX = 15.0;
  static const _biasPositionY = 30.0;

  static const _depthsY = -0.0001 * _biasDepthsY;
  static const _depthsZ = 0.001 * _biasDepthsZ;

  late Animation<double> _animatedDepthsY;
  late Animation<double> _animatedDepthsZ;

  static const _insetY = -48.0;
  static const _insetZ = 100.0;

  bool _isSliding = false;

  double get middleRandom =>
      (Random(widget.albumId.hashCode + widget.index).nextDouble() - 0.5);

  Offset _origin = Offset.zero;

  Offset _position = Offset.zero;

  double get _rotationZ => pi / 30 * middleRandom;

  late Animation<double> _animatedRotationZ;

  double get _positionX =>
      widget.index == 0 ? 0.0 : _biasPositionX * middleRandom;

  late Animation<double> _animatedPositionX;

  double get _positionY =>
      -widget.index.toDouble() * 0.1 * _biasDepthsY +
      _biasPositionY * middleRandom +
      _insetY;

  late Animation<double> _animatedPositionY;

  double get _positionZ => -widget.index.toDouble() * _biasDepthsZ + _insetZ;

  late Animation<double> _animatedPositionZ;

  late final AnimationController _popAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..addListener(update);

  late final AnimationController _pickAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  )..addListener(update);
  late final AnimationController _leaveAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  )..addListener(update);

  late final AnimationController _slideAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..addListener(update);

  void update() => setState(() {});

  void onDragStart(DragStartDetails details) {
    if (_isSliding) {
      return;
    }

    _leaveAnimationController.stop();

    _origin = details.localPosition;

    final curve =
        CurvedAnimation(parent: _pickAnimationController, curve: Curves.ease);

    _animatedRotationZ =
        Tween(begin: _animatedRotationZ.value, end: 0.0).animate(curve);

    _animatedDepthsY =
        Tween(begin: _animatedDepthsY.value, end: 0.0).animate(curve);

    _animatedDepthsZ =
        Tween(begin: _animatedDepthsZ.value, end: 0.0).animate(curve);

    _animatedPositionY =
        Tween(begin: _animatedPositionY.value, end: 1 * _insetY).animate(curve);

    _animatedPositionZ =
        Tween(begin: _animatedPositionZ.value, end: 0.0).animate(curve);

    _pickAnimationController.forward(from: 0.0);
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (_isSliding) {
      return;
    }

    setState(() {
      _position += details.localPosition - _origin;
    });

    _origin = details.localPosition;
  }

  void onDragEnd(DragEndDetails details) {
    if (_isSliding) {
      return;
    }

    _pickAnimationController.stop();

    final velocity = details.velocity.pixelsPerSecond;

    if (velocity.distance.abs() < 500.0) {
      leave();
    } else {
      slide(velocity);
    }
  }

  void slide(Offset velocitiy) {
    _isSliding = true;

    final radian = velocitiy.direction;

    final size = MediaQuery.of(context).size;

    final distance = max(size.width, size.height);

    final curve = CurvedAnimation(
        parent: _slideAnimationController, curve: Curves.easeOut);

    _animatedRotationZ = Tween(
            begin: _animatedRotationZ.value, end: velocitiy.dx.sign * pi * 1.0)
        .animate(curve);

    _animatedPositionY =
        Tween(begin: _animatedPositionY.value, end: distance * sin(radian))
            .animate(curve);

    _animatedPositionX =
        Tween(begin: _animatedPositionX.value, end: distance * cos(radian))
            .animate(curve);

    _slideAnimationController.forward(from: 0.0);

    _slideAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onRemove(widget.index);
      }
    });
  }

  void leave() {
    final curve =
        CurvedAnimation(parent: _leaveAnimationController, curve: Curves.ease);

    _animatedRotationZ =
        Tween(begin: _animatedRotationZ.value, end: _rotationZ).animate(curve);

    _animatedDepthsY =
        Tween(begin: _animatedDepthsY.value, end: _depthsY).animate(curve);

    _animatedDepthsZ =
        Tween(begin: _animatedDepthsZ.value, end: _depthsZ).animate(curve);

    _animatedPositionY =
        Tween(begin: _animatedPositionY.value, end: _positionY).animate(curve);

    _animatedPositionZ =
        Tween(begin: _animatedPositionZ.value, end: _positionZ).animate(curve);

    final animation = Tween(begin: _position, end: Offset.zero).animate(curve);

    listener() {
      _position = animation.value;
    }

    animation.addListener(listener);

    _leaveAnimationController.forward(from: 0.0);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        animation.removeListener(listener);
      }
    });
  }

  void pop() async {
    await Future.delayed(
        Duration(milliseconds: widget.popDuration * widget.index));

    _popAnimationController.forward();
  }

  @override
  void initState() {
    super.initState();
    final curve =
        CurvedAnimation(parent: _popAnimationController, curve: Curves.easeOut);

    _animatedRotationZ =
        Tween(begin: _rotationZ, end: _rotationZ).animate(curve);

    _animatedDepthsY = Tween(begin: _depthsY, end: _depthsY).animate(curve);

    _animatedDepthsZ = Tween(begin: _depthsZ, end: _depthsZ).animate(curve);

    _animatedPositionX =
        Tween(begin: _positionX, end: _positionX).animate(curve);

    _animatedPositionY =
        Tween(begin: _positionY * 20, end: _positionY).animate(curve);

    _animatedPositionZ =
        Tween(begin: _positionZ * -10, end: _positionZ).animate(curve);

    pop();
  }

  @override
  void didUpdateWidget(covariant AlbumFloorWidget oldWidget) {
    if (widget.mustRemove) {
      Future.delayed(Duration.zero, () => slide(const Offset(0.05, 1)));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: _isSliding
          ? content(context)
          : Container(color: Colors.transparent, child: content(context)),
    );
  }

  Widget content(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 16.0;

    return Center(
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 1, _animatedDepthsY.value)
          ..setEntry(3, 2, _animatedDepthsZ.value)
          ..translate(
            _animatedPositionX.value + _position.dx,
            _animatedPositionY.value + _position.dy,
            _animatedPositionZ.value,
          ),
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()..rotateZ(_animatedRotationZ.value),
          child: GestureDetector(
            onPanStart: onDragStart,
            onPanUpdate: onDragUpdate,
            onPanEnd: onDragEnd,
            child: Container(
              width: width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0.0, 4.0),
                  blurRadius: 12.0,
                  spreadRadius: 2.0,
                ),
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Image(
                      image: NetworkImage(widget.imageUri),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "${widget.date.year}.${widget.date.month}.${widget.date.day}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16.0, height: 1.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    widget.description ?? "",
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 16.0, height: 1.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _popAnimationController.dispose();
    _pickAnimationController.dispose();
    _leaveAnimationController.dispose();
    _slideAnimationController.dispose();

    super.dispose();
  }
}
