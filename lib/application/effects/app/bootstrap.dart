import 'package:album/application/events/app/started.dart';
import 'package:album/application/events/bootstrap/bootstrap_finished.dart';
import 'package:album/application/events/bootstrap/env_loaded.dart';
import 'package:album/application/events/bootstrap/infra_loaded.dart';
import 'package:album/application/events/bootstrap/repository_loaded.dart';
import 'package:album/application/events/bootstrap/service_loaded.dart';
import 'package:album/firebase_options.dart';
import 'package:album/infrastructure/repositories/auth.dart';
import 'package:album/infrastructure/repositories/image.dart';
import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/jwt/jwt.dart';
import 'package:album/infrastructure/services/precache/precache.dart';
import 'package:album/infrastructure/services/share/share.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BootstrapEffect extends Effect {
  BootstrapEffect() {
    on<AppStarted>((event) async {
      await dotenv.load();

      dispatch(const EnvLoaded());
    });
    on<EnvLoaded>((event) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      dispatch(const InfraLoaded());
    });
    on<InfraLoaded>((event) {
      Dependency.single<AuthRepository>(AuthRepository());
      Dependency.single<ImageRepository>(ImageRepository());

      dispatch(const RepositoryLoaded());
    });
    on<RepositoryLoaded>((event) {
      final apiHost =
          kDebugMode ? dotenv.get("API_HOST_FOR_DEV") : dotenv.get("API_HOST");

      Dependency.factory<Client>(() => Client(apiHost));
      Dependency.single<PrecacheService>(PrecacheService());
      Dependency.single<JwtService>(JwtService());
      Dependency.single<ShareService>(ShareService());

      dispatch(const ServiceLoaded());
    });
    on<ServiceLoaded>((event) {
      dispatch(const AppReady());
    });
  }
}
