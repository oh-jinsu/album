import 'package:album/effects/bootstrap.dart';
import 'package:album/events/app_started.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codux/codux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const App());

class App extends Component {
  const App({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useEffect(() => BootstrapEffects());

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
        return null;
      },
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
      home: const Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
