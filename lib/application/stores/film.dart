import 'package:album/application/events/film/counted.dart';
import 'package:codux/codux.dart';

class FilmStore extends Store<int> {
  FilmStore() {
    on<FilmCounted>((current, event) {
      return event.value;
    });
  }
}
