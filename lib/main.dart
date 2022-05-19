import 'package:album/application/effects/app/auto_sign_in.dart';
import 'package:album/application/effects/app/bootstrap.dart';
import 'package:album/application/effects/app/precache_album_list.dart';
import 'package:album/application/effects/app/escort.dart';
import 'package:album/application/effects/app/guest_sign_in.dart';
import 'package:album/application/effects/app/invitation.dart';
import 'package:album/application/effects/app/navigation.dart';
import 'package:album/application/effects/app/prefetch_album_list.dart';
import 'package:album/application/effects/app/prefetch_user.dart';
import 'package:album/application/events/app/started.dart';
import 'package:album/application/stores/list_of_album.dart';
import 'package:album/presentation/pages/album.dart';
import 'package:album/presentation/pages/home.dart';
import 'package:album/presentation/pages/invitation.dart';
import 'package:album/presentation/pages/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:codux/codux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const App());

class App extends Component {
  const App({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => ListOfAlbumStore());

    useEffect(() => NavigationEffect());
    useEffect(() => InvitationEffect());
    useEffect(() => BootstrapEffect(), until: SplashPage);
    useEffect(() => AutoSignInEffect(), until: SplashPage);
    useEffect(() => GuestSignInEffect(), until: SplashPage);
    useEffect(() => PrefetchUserEffect(), until: SplashPage);
    useEffect(() => PrefetchAlbumListEffect(), until: SplashPage);
    useEffect(() => PrecacheAlbumListEffect(), until: SplashPage);
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
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const SplashPage(),
          );
        }

        if (settings.name == "/invitation") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const InvitationPage(),
          );
        }

        if (settings.name == "/home") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const HomePage(),
          );
        }

        if (settings.name == "/album") {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => const AlbumPage(),
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
