import 'package:album/application/events/invitation/form_canceled.dart';
import 'package:album/application/events/invitation/form_pending.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/invitation/form.dart';
import 'package:codux/codux.dart';

const initialState = InvitationFormModel(isPending: false);

class InvitationFormStore extends Store<InvitationFormModel> {
  InvitationFormStore() : super(initialState: initialState) {
    on<InvitationFormPending>((current, event) {
      return current.state.copy(isPending: const New(true));
    });
    on<InvitationFormCanceled>((current, event) {
      return current.state.copy(isPending: const New(false));
    });
  }
}
