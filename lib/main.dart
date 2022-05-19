import 'package:album/effects/auto_sign_in.dart';
import 'package:album/effects/bootstrap.dart';
import 'package:album/effects/escort.dart';
import 'package:album/effects/guest_sign_in.dart';
import 'package:album/effects/invitation.dart';
import 'package:album/effects/navigation.dart';
import 'package:album/effects/prefetch_album_list.dart';
import 'package:album/effects/prefetch_user.dart';
import 'package:album/events/app/started.dart';
import 'package:album/pages/home.dart';
import 'package:album/pages/invitation.dart';
import 'package:album/pages/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:codux/codux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const App());

class App extends Component {
  const App({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useEffect(() => NavigationEffect());
    useEffect(() => InvitationEffect());
    useEffect(() => BootstrapEffect(), until: SplashPage);
    useEffect(() => AutoSignInEffect(), until: SplashPage);
    useEffect(() => GuestSignInEffect(), until: SplashPage);
    useEffect(() => PrefetchUserEffect(), until: SplashPage);
    useEffect(() => PrefetchAlbumListEffect(), until: SplashPage);
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
