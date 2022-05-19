import 'package:codux/codux.dart';

class AlbumFormSumitted extends Event {
  final String title;

  const AlbumFormSumitted({
    required this.title,
  });
}
