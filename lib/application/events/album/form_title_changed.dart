import "package:codux/codux.dart";

class AlbumFormTitleChanged implements Event {
  final String value;

  const AlbumFormTitleChanged(this.value);
}
