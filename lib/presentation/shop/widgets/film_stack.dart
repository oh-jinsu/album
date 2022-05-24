import 'dart:math';

import 'package:album/presentation/shop/widgets/film.dart';
import 'package:flutter/material.dart';

class ShopFilmImageStack extends StatelessWidget {
  const ShopFilmImageStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < 5; i++)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(
                  Random().nextDouble() * 10 - 5.0,
                  Random().nextDouble() * 10 - 5.0,
                )
                ..rotateZ(pi * (Random().nextDouble() * 10 - 5.0) / 360),
              child: const ShopFilmImage(),
            ),
        ],
      ),
    );
  }
}
