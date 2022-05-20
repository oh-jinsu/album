import 'package:codux/codux.dart';

class AlbumShareRequested implements Event {
  final String id;

  const AlbumShareRequested(this.id);
}
