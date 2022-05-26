import 'package:album/application/effects/app/auto_sign_in.dart';
import 'package:album/application/effects/app/bootstrap.dart';
import 'package:album/application/effects/album/precache_found_list.dart';
import 'package:album/application/effects/app/escort.dart';
import 'package:album/application/effects/app/sign_out.dart';
import 'package:album/application/effects/common/dialog.dart';
import 'package:album/application/effects/film/count.dart';
import 'package:album/application/effects/film/request_film.dart';
import 'package:album/application/effects/shop/fetch_list_of_item.dart';
import 'package:album/application/effects/shop/purchase.dart';
import 'package:album/application/effects/sign_in/guest_sign_in.dart';
import 'package:album/application/effects/invitation/invitation.dart';
import 'package:album/application/effects/app/navigation.dart';
import 'package:album/application/effects/app/fetch_album_list_after_sign_in.dart';
import 'package:album/application/effects/app/fetch_user_after_sign_in.dart';
import 'package:album/application/effects/user/precache_user.dart';
import 'package:album/application/events/app/started.dart';
import 'package:album/application/stores/film.dart';
import 'package:album/application/stores/list_of_album.dart';
import 'package:album/application/stores/shop.dart';
import 'package:album/application/stores/sign_out_form.dart';
import 'package:album/application/stores/user.dart';
import 'package:album/presentation/album/page.dart';
import 'package:album/presentation/help/page.dart';
import 'package:album/presentation/home/page.dart';
import 'package:album/presentation/profile/page.dart';
import 'package:album/presentation/profile_editor/page.dart';
import 'package:album/presentation/shop/page.dart';
import 'package:album/presentation/signin/page.dart';
import 'package:album/presentation/signup/page.dart';
import 'package:album/presentation/splash/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:codux/codux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const App());

class App extends Component {
  const App({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => ListOfAlbumStore());
    useStore(() => UserStore());
    useStore(() => FilmStore());
    useStore(() => ShopStore());
    useStore(() => SignOutFormStore());

    useEffect(() => NavigationEffect());
    useEffect(() => DialogEffect());
    useEffect(() => InvitationEffect());
    useEffect(() => GuestSignInEffect());
    useEffect(() => SignOutEffect());
    useEffect(() => FetchUserAfterSignInEffect());
    useEffect(() => FetchAlbumListAfterSignInEffect());
    useEffect(() => PrecacheUserEffect());
    useEffect(() => PrecacheFoundAlbumListEffect());
    useEffect(() => CountFilmEffect());
    useEffect(() => FetchListOfShopItemEffect());
    useEffect(() => PurchaseEffect());
    useEffect(() => RequestFilmEffect());

    useEffect(() => BootstrapEffect(), until: SplashPage);
    useEffect(() => AutoSignInEffect(), until: SplashPage);
    useEffect(() => EscortEffect(), until: SplashPage);

    super.onCreated(context);
  }

  @override
  void onStarted(BuildContext context) {
    dispatch(const AppStarted());

    super.onStarted(context);
  }

  @override
  Widget render(BuildContext context) {
    return CupertinoApp(
      onGenerateRoute: (settings) {
        if (settings.name == "/splash") {
          return PageRouteBuilder(
            settings: settings,
            transitionDuration: Duration.zero,
            pageBuilder: (context, animation, secondAnimation) =>
                const SplashPage(),
          );
        }

        if (settings.name == "/home") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const HomePage(),
          );
        }

        if (settings.name == "/album") {
          final arguments = settings.arguments as Map;

          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => AlbumPage(
              id: arguments["id"],
              title: arguments["title"],
            ),
          );
        }

        if (settings.name == "/shop") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const ShopPage(),
          );
        }

        if (settings.name == "/profile") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const ProfilePage(),
          );
        }

        if (settings.name == "/profile/edit") {
          final arguments = settings.arguments as Map;

          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => ProfileEditorPage(
              name: arguments["name"],
              email: arguments["email"],
              avatar: arguments["avatar"],
            ),
          );
        }

        if (settings.name == "/signin") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const SignInPage(),
          );
        }

        if (settings.name == "/signup") {
          final arguments = settings.arguments as Map;

          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => SignUpPage(
              provider: arguments["provider"],
              idToken: arguments["id_token"],
              name: arguments["name"],
              email: arguments["email"],
            ),
          );
        }

        if (settings.name == "/help") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const HelpPage(),
          );
        }

        return null;
      },
      initialRoute: "/splash",
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
    );
  }
}
