import 'package:album/application/effects/user/form_pick_avatar.dart';
import 'package:album/application/effects/user/form_submit.dart';
import 'package:album/application/effects/user/waiter.dart';
import 'package:album/application/events/user/profile_form_email_changed.dart';
import 'package:album/application/events/user/profile_form_image_picker_tapped.dart';
import 'package:album/application/events/user/profile_form_name_changed.dart';
import 'package:album/application/events/user/profile_form_submitted.dart';
import 'package:album/application/models/common/state.dart';
import 'package:album/application/models/user/profile_form.dart';
import 'package:album/application/stores/profile_form.dart';
import 'package:album/presentation/profile_editor/widgets/avatar.dart';
import 'package:album/presentation/profile_editor/widgets/container.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class ProfileEditorPage extends Component {
  final String name;
  final String? email;
  final String? avatar;

  const ProfileEditorPage({
    Key? key,
    required this.avatar,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => ProfileFormStore());

    useEffect(() => PickProfileFormAvatarEffect());
    useEffect(() => SubmitProfileFormEffect());
    useEffect(() => ProfileWaiterEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text("이름, 이메일, 프로필 사진"),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: Border(),
        transitionBetweenRoutes: false,
      ),
      child: StreamBuilder(
        stream: find<ProfileFormStore>().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final model = snapshot.data as ProfileFormModel;

            return ProfileEditorContainer(
              bottom: CupertinoButton(
                color: model.state == SubmitFormState.enabled
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.quaternarySystemFill,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: model.state == SubmitFormState.pending
                        ? const CupertinoActivityIndicator(
                            color: CupertinoColors.white,
                          )
                        : Text(
                            "수정",
                            style: TextStyle(
                              color: model.state == SubmitFormState.enabled
                                  ? CupertinoColors.white
                                  : CupertinoColors.inactiveGray,
                            ),
                          ),
                  ),
                ),
                onPressed: () {
                  if (model.state != SubmitFormState.enabled) {
                    return;
                  }

                  dispatch(ProfileFormSubmitted(
                    avatar: model.avatar,
                    name: model.name,
                    email: model.email,
                  ));
                },
              ),
              children: [
                const SizedBox(height: 24.0),
                ProfileAvatar(
                  defaultNetworkImageUri: avatar,
                  image: model.avatar,
                  onTap: () => dispatch(const ProfileFormAvatarPickerTapped()),
                ),
                const SizedBox(height: 40.0),
                CupertinoFormSection(
                  footer: model.nameMessage != null
                      ? Text(
                          model.nameMessage!,
                          style: const TextStyle(
                            color: CupertinoColors.destructiveRed,
                          ),
                        )
                      : null,
                  margin: EdgeInsets.only(
                      bottom: model.nameMessage != null ? 8.0 : 0.0),
                  children: [
                    CupertinoTextFormFieldRow(
                      prefix: const Icon(
                        CupertinoIcons.person_alt,
                        color: CupertinoColors.systemGrey5,
                      ),
                      initialValue: name,
                      placeholder: "이름",
                      keyboardType: TextInputType.text,
                      onChanged: (v) => dispatch(ProfileFormNameChanged(v)),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: const Icon(
                        CupertinoIcons.mail_solid,
                        color: CupertinoColors.systemGrey5,
                      ),
                      initialValue: email,
                      keyboardType: TextInputType.emailAddress,
                      placeholder: "이메일",
                      onChanged: (v) => dispatch(ProfileFormEmailChanged(v)),
                    ),
                  ],
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
