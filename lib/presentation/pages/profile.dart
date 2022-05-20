import 'package:album/application/events/navigation/pushed.dart';
import 'package:album/application/models/common/option.dart';
import 'package:album/application/models/user/user.dart';
import 'package:album/application/stores/user.dart';
import 'package:album/presentation/components/common/bottom_navigation.dart';
import 'package:album/presentation/components/profile/widgets/avatar.dart';
import 'package:album/presentation/components/profile/widgets/menu.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

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
                            ProfileAvatar(
                              imageUri: data.value.avatarImageUri,
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
                            CupertinoFormSection(
                              header: const Text("계정"),
                              children: [
                                ProfileMenu(
                                  onTap: () {},
                                  prefix: const Text("이름, 이메일, 프로필 사진"),
                                  child: const Icon(
                                    CupertinoIcons.chevron_forward,
                                    size: 20.0,
                                    color: CupertinoColors.systemGrey3,
                                  ),
                                ),
                                ProfileMenu(
                                  onTap: () {},
                                  prefix: const Text(
                                    "구매 내역",
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
                              header: const Text("계정"),
                              children: [
                                ProfileMenu(
                                  onTap: () =>
                                      dispatch(const Pushed("/signin")),
                                  prefix: const Text(
                                    "로그인",
                                    style: TextStyle(
                                        color: CupertinoColors.activeBlue),
                                  ),
                                ),
                              ],
                            ),
                          CupertinoFormSection(
                            header: const Text("일반"),
                            children: [
                              ProfileMenu(
                                onTap: () {},
                                prefix: const Text("서비스이용약관"),
                                child: const Icon(
                                  CupertinoIcons.chevron_forward,
                                  size: 20.0,
                                  color: CupertinoColors.systemGrey3,
                                ),
                              ),
                              ProfileMenu(
                                onTap: () {},
                                prefix: const Text("개인정보처리방침"),
                                child: const Icon(
                                  CupertinoIcons.chevron_forward,
                                  size: 20.0,
                                  color: CupertinoColors.systemGrey3,
                                ),
                              ),
                              ProfileMenu(
                                onTap: () {},
                                prefix: const Text("도움말 및 문의"),
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
                              header: const Text("기타"),
                              children: [
                                ProfileMenu(
                                  onTap: () {},
                                  prefix: const Text(
                                    "로그아웃",
                                    style: TextStyle(
                                      color: CupertinoColors.destructiveRed,
                                    ),
                                  ),
                                ),
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
