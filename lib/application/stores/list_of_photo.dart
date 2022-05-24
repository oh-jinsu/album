import 'package:album/application/events/photo/deleted.dart';
import 'package:album/application/events/photo/precached_added.dart';
import 'package:album/application/events/photo/precached_list_of_photo_found.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/photo/list_of_photo.dart';
import 'package:codux/codux.dart';

class ListOfPhotoStore extends Store<ListOfPhotoModel> {
  ListOfPhotoStore() {
    on<PrecachedListOfPhotoFound>((current, event) {
      if (current.hasState) {
        return current.state.copy(
          next: New(event.model.next),
          items: New([...current.state.items, ...event.model.items]),
        );
      }

      return event.model;
    });
    on<PrecachedPhotoAdded>((current, event) {
      if (current.hasState) {
        return current.state.copy(
          items: New([event.model, ...current.state.items]),
        );
      }

      return ListOfPhotoModel(next: null, items: [event.model]);
    });
    on<PhotoDeleted>((current, event) {
      return current.state.copy(
        items: New(
          current.state.items
              .where((element) => element.id != event.id)
              .toList(),
        ),
      );
    });
  }
}
