import 'package:codux/codux.dart';

class AlbumOpened implements Event {
  final String id;

  const AlbumOpened({
    required this.id,
  });
}
