import 'package:album/application/events/photo/added.dart';
import 'package:album/application/events/photo/list_of_found.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/photo/list_of_photo.dart';
import 'package:codux/codux.dart';

class ListOfPhotoStore extends Store<ListOfPhotoModel> {
  ListOfPhotoStore() {
    on<ListOfPhotoFound>((current, event) {
      if (current.hasState) {
        return current.state.copy(
          next: New(event.model.next),
          items: New([...current.state.items, ...event.model.items]),
        );
      }

      return event.model;
    });
    on<PhotoAdded>((current, event) {
      if (current.hasState) {
        return current.state.copy(
          items: New([event.model, ...current.state.items]),
        );
      }

      return ListOfPhotoModel(next: null, items: [event.model]);
    });
  }
}
