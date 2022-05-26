import 'package:album/application/effects/signup/form_pick_avatar.dart';
import 'package:album/application/effects/signup/form_submit.dart';
import 'package:album/application/effects/signup/waiter.dart';
import 'package:album/application/events/auth/sign_up_form_email_changed.dart';
import 'package:album/application/events/auth/sign_up_form_image_picker_tapped.dart';
import 'package:album/application/events/auth/sign_up_form_name_changed.dart';
import 'package:album/application/events/auth/sign_up_form_privacy_agreement_changed.dart';
import 'package:album/application/events/auth/sign_up_form_submitted.dart';
import 'package:album/application/models/auth/sign_up_form.dart';
import 'package:album/application/models/common/state.dart';
import 'package:album/application/stores/sign_up_form.dart';
import 'package:album/presentation/common/widgets/button.dart';
import 'package:album/presentation/signup/widgets/avatar.dart';
import 'package:album/presentation/signup/widgets/container.dart';
import 'package:album/presentation/signup/widgets/radio_box.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends Component {
  final String provider;
  final String idToken;
  final String? name;
  final String? email;

  const SignUpPage({
    Key? key,
    required this.provider,
    required this.idToken,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => SignUpFormStore());

    useEffect(() => SignUpPageWaiterEffect());
    useEffect(() => SubmitSignUpFormEffect());
    useEffect(() => PickSignUpFormAvatarEffect());

    super.onCreated(context);
  }

  @override
  void onStarted(BuildContext context) {
    final name = this.name;

    if (name != null) {
      dispatch(SignUpFormNameChanged(name));
    }

    final email = this.email;

    if (email != null) {
      dispatch(SignUpFormEmailChanged(email));
    }

    super.onStarted(context);
  }

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text("회원가입"),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: Border(),
        transitionBetweenRoutes: false,
      ),
      child: StreamBuilder(
        stream: find<SignUpFormStore>().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final model = snapshot.data as SignUpFormModel;

            return SignUpContainer(
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
                            "확인",
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

                  dispatch(
                    SignUpFormSubmitted(
                      provider: provider,
                      idToken: idToken,
                      avatar: model.avatar,
                      name: model.name,
                      email: model.email,
                    ),
                  );
                },
              ),
              children: [
                const SizedBox(height: 24.0),
                SignUpAvatar(
                  image: model.avatar,
                  onTap: () => dispatch(
                    const SignUpFormAvatarPickerTapped(),
                  ),
                ),
                const SizedBox(height: 8.0),
                CupertinoFormSection(
                  header: const Text("필수"),
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
                      autofocus: name == null,
                      prefix: const Icon(
                        CupertinoIcons.person_alt,
                        color: CupertinoColors.systemGrey5,
                      ),
                      initialValue: name,
                      placeholder: "이름",
                      keyboardType: TextInputType.text,
                      onChanged: (v) => dispatch(SignUpFormNameChanged(v)),
                    ),
                  ],
                ),
                CupertinoFormSection(
                  header: const Text("선택"),
                  children: [
                    CupertinoTextFormFieldRow(
                      prefix: const Icon(
                        CupertinoIcons.mail_solid,
                        color: CupertinoColors.systemGrey5,
                      ),
                      initialValue: email,
                      keyboardType: TextInputType.emailAddress,
                      placeholder: "이메일",
                      onChanged: (v) => dispatch(SignUpFormEmailChanged(v)),
                    ),
                  ],
                ),
                CupertinoFormSection(
                  header: const Text("동의"),
                  children: [
                    // CupertinoFormRow(
                    //   padding: const EdgeInsets.only(right: 12.0),
                    //   prefix: GestureDetector(
                    //     onTap: () => dispatch(SignUpFormServiceAgreementChanged(
                    //       !model.isServiceAgreed,
                    //     )),
                    //     child: Container(
                    //       color: Colors.transparent,
                    //       padding: const EdgeInsets.symmetric(
                    //         vertical: 12.0,
                    //         horizontal: 20.0,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           AppRadioBox(enabled: model.isServiceAgreed),
                    //           const SizedBox(width: 8.0),
                    //           const Text(
                    //             "서비스이용약관",
                    //             style: TextStyle(height: 1.3),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    //   child: Button(
                    //     onPressed: () {},
                    //     child: const Icon(
                    //       CupertinoIcons.chevron_forward,
                    //       size: 20.0,
                    //       color: CupertinoColors.systemGrey3,
                    //     ),
                    //   ),
                    // ),
                    CupertinoFormRow(
                      padding: const EdgeInsets.only(right: 12.0),
                      prefix: GestureDetector(
                        onTap: () => dispatch(SignUpFormPrivacyAgreementChanged(
                          !model.isPrivacyAgreed,
                        )),
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 20.0,
                          ),
                          child: Row(
                            children: [
                              AppRadioBox(enabled: model.isPrivacyAgreed),
                              const SizedBox(width: 8.0),
                              const Text(
                                "개인정보처리방침",
                                style: TextStyle(height: 1.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: Button(
                        onPressed: () {
                          final url = Uri.parse(
                              "https://github.com/oh-jinsu/album/blob/main/privacy.md");

                          launchUrl(url);
                        },
                        child: const Icon(
                          CupertinoIcons.chevron_forward,
                          size: 20.0,
                          color: CupertinoColors.systemGrey3,
                        ),
                      ),
                    )
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
