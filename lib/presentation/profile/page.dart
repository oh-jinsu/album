import 'package:album/application/events/auth/sign_out_requested.dart';
import 'package:album/application/events/navigation/pushed.dart';
import 'package:album/application/models/auth/sign_out_form.dart';
import 'package:album/application/models/common/option.dart';
import 'package:album/application/models/user/user.dart';
import 'package:album/application/stores/sign_out_form.dart';
import 'package:album/application/stores/user.dart';
import 'package:album/presentation/common/components/bottom_navigation.dart';
import 'package:album/presentation/common/widgets/avatar.dart';
import 'package:album/presentation/common/widgets/menu.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends Component {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: StreamBuilder(
                  stream: find<UserStore>().stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as Option<UserModel>;

                      return Column(
                        children: [
                          const SizedBox(height: 16.0),
                          if (data is Some<UserModel>) ...[
                            const SizedBox(height: 24.0),
                            Avatar(
                              imageUri: data.value.avatarImageUri,
                              radius: 92.0,
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              data.value.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            if (data.value.email != null) ...[
                              const SizedBox(height: 4.0),
                              Text(
                                data.value.email!,
                                style: const TextStyle(
                                  color: CupertinoColors.inactiveGray,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                            const SizedBox(height: 24.0),
                            CupertinoFormSection(
                              children: [
                                FormMenu(
                                  onTap: () => dispatch(Pushed(
                                    "/profile/edit",
                                    arguments: {
                                      "name": data.value.name,
                                      "email": data.value.email,
                                      "avatar": data.value.avatarImageUri,
                                    },
                                  )),
                                  prefix: const Text("??????, ?????????, ????????? ??????"),
                                  child: const Icon(
                                    CupertinoIcons.chevron_forward,
                                    size: 20.0,
                                    color: CupertinoColors.systemGrey3,
                                  ),
                                ),
                                FormMenu(
                                  onTap: () =>
                                      dispatch(const Pushed("/account")),
                                  prefix: const Text(
                                    "??????",
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.chevron_forward,
                                    size: 20.0,
                                    color: CupertinoColors.systemGrey3,
                                  ),
                                ),
                              ],
                            ),
                          ] else
                            CupertinoFormSection(
                              header: const Text("??????"),
                              children: [
                                FormMenu(
                                  onTap: () =>
                                      dispatch(const Pushed("/signin")),
                                  prefix: const Text(
                                    "?????????",
                                    style: TextStyle(
                                        color: CupertinoColors.activeBlue),
                                  ),
                                ),
                              ],
                            ),
                          CupertinoFormSection(
                            header: const Text("??????"),
                            children: [
                              FormMenu(
                                onTap: () {
                                  final url = Uri.parse(
                                      "https://github.com/oh-jinsu/album/blob/main/privacy.md");

                                  launchUrl(url);
                                },
                                prefix: const Text("????????????????????????"),
                                child: const Icon(
                                  CupertinoIcons.chevron_forward,
                                  size: 20.0,
                                  color: CupertinoColors.systemGrey3,
                                ),
                              ),
                              FormMenu(
                                onTap: () => dispatch(const Pushed("/help")),
                                prefix: const Text("????????? ??? ??????"),
                                child: const Icon(
                                  CupertinoIcons.chevron_forward,
                                  size: 20.0,
                                  color: CupertinoColors.systemGrey3,
                                ),
                              )
                            ],
                          ),
                          if (data is Some<UserModel>)
                            CupertinoFormSection(
                              header: const Text("??????"),
                              children: [
                                StreamBuilder(
                                  stream: find<SignOutFormStore>().stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final data =
                                          snapshot.data as SignOutFormModel;

                                      return FormMenu(
                                        onTap: () {
                                          if (data.isPending) {
                                            return;
                                          }

                                          dispatch(const SignOutRequested());
                                        },
                                        prefix: Text(
                                          "????????????",
                                          style: TextStyle(
                                            color: data.isPending
                                                ? CupertinoColors.inactiveGray
                                                : CupertinoColors
                                                    .destructiveRed,
                                          ),
                                        ),
                                        child: data.isPending
                                            ? const CupertinoActivityIndicator()
                                            : null,
                                      );
                                    }

                                    return Container();
                                  },
                                )
                              ],
                            ),
                        ],
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ),
          const BottomNavigationComponent(currentIndex: 1),
        ],
      ),
    );
  }
}
