import 'package:album/application/events/film/counted.dart';
import 'package:album/application/events/film/used.dart';
import 'package:codux/codux.dart';

class FilmStore extends Store<int> {
  FilmStore() {
    on<FilmCounted>((current, event) {
      return event.value;
    });
    on<FilmUsed>((current, event) {
      return current.state - 1;
    });
  }
}
