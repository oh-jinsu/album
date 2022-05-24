import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/film/used.dart';
import 'package:album/application/events/photo/added.dart';
import 'package:album/application/events/photo/form_completed.dart';
import 'package:album/application/events/photo/form_pending.dart';
import 'package:album/application/events/photo/submitted.dart';
import 'package:album/application/events/shop/purchase_canceled.dart';
import 'package:album/application/events/shop/purchase_completed.dart';
import 'package:album/application/events/shop/purchase_requested.dart';
import 'package:album/application/models/photo/photo.dart';
import 'package:album/application/stores/film.dart';
import 'package:album/application/stores/shop.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';

class SubmitPhotoFormEffect extends Effect with AuthEffectMixin {
  PhotoFormSubmitted? pendingEvent;

  SubmitPhotoFormEffect() {
    on<PurchaseCanceled>((event) {
      if (pendingEvent != null) {
        dispatch(const PhotoFormCompleted());

        pendingEvent = null;
      }
    });
    on<PurchaseCompleted>((event) {
      if (pendingEvent != null) {
        _submit(pendingEvent!);

        pendingEvent = null;
      }
    });
    on<PhotoFormSubmitted>((event) async {
      dispatch(const PhotoFormPending());

      pendingEvent = null;

      final filmStore = find<FilmStore>();

      if (filmStore.stream.value < 1) {
        final shopStore = find<ShopStore>();

        final shopItem = shopStore.stream.value[0];

        dispatch(PurchaseRequested(shopItem.details));

        pendingEvent = event;

        return;
      }

      _submit(event);
    });
  }

  _submit(PhotoFormSubmitted event) async {
    final imageRes = await withAuth(
      (client) => client.file(event.file).post("util/image"),
    );

    if (imageRes is! SuccessResponse) {
      dispatch(const PhotoFormCompleted());

      return dispatch(const DialogRequested("예기치 못한 오류입니다."));
    }

    final imageId = imageRes.body["id"];

    final response = await withAuth(
      (client) => client.body({
        "album_id": event.albumId,
        "image": imageId,
        "date": event.date.toIso8601String(),
        "description": event.description,
      }).post("photo"),
    );

    if (response is! SuccessResponse) {
      dispatch(const PhotoFormCompleted());

      return dispatch(DialogRequested(
        response is FailureResponse ? response.message : "예기치 못한 오류입니다.",
      ));
    }

    final model = PhotoModel.fromJson(response.body);

    dispatch(PhotoAdded(model));

    dispatch(const FilmUsed());

    dispatch(const PhotoFormCompleted());
  }
}
