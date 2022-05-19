import 'package:codux/codux.dart';

class AlbumFormSumitted implements Event {
  final String title;

  const AlbumFormSumitted({
    required this.title,
  });
}
