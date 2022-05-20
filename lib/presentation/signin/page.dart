import 'package:album/application/effects/auth/fetch_user.dart';
import 'package:album/application/effects/auth/sign_in.dart';
import 'package:album/application/effects/auth/sign_in_with_apple.dart';
import 'package:album/application/effects/auth/sign_in_with_google.dart';
import 'package:album/application/events/auth/apple_sign_in_requested.dart';
import 'package:album/application/events/auth/google_sign_in_requested.dart';
import 'package:album/application/models/auth/sign_in_form.dart';
import 'package:album/application/stores/sign_in_form.dart';
import 'package:album/presentation/signin/widgets/description.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class SignInPage extends Component {
  const SignInPage({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => SignInFormStore());

    useEffect(() => SignInEffect());
    useEffect(() => SignInWithAppleEffect());
    useEffect(() => SignInWithGoogleEffect());
    useEffect(() => FetchUserEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBackground,
        border: Border(),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: StreamBuilder(
            stream: find<SignInFormStore>().stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final model = snapshot.data as SignInFormModel;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 3),
                    const SignInDescription(),
                    const SizedBox(height: 48.0),
                    Center(
                      child: SignInButton(
                        Buttons.AppleDark,
                        onPressed: () {
                          if (model.isPending) {
                            return;
                          }

                          dispatch(const AppleSignInRequested());
                        },
                        text: "Apple로 로그인",
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Center(
                      child: SignInButton(
                        Buttons.GoogleDark,
                        onPressed: () {
                          if (model.isPending) {
                            return;
                          }

                          dispatch(const GoogleSignInRequested());
                        },
                        text: "Google로 로그인",
                      ),
                    ),
                    const Spacer(flex: 5)
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
