import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/navigation/pushed.dart';
import 'package:album/application/events/navigation/replaced.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class NavigationEffect extends Effect {
  NavigationEffect() {
    on<Pushed>((event) {
      Navigator.of(requireContext()).pushNamed(
        event.name,
        arguments: event.arguments,
      );
    });
    on<Replaced>((event) {
      Navigator.of(requireContext()).pushReplacementNamed(
        event.name,
        arguments: event.arguments,
      );
    });
    on<Popped>((event) {
      Navigator.of(requireContext()).pop();
    });
  }
}
