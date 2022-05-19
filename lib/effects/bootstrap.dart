import 'package:album/events/app_started.dart';
import 'package:album/events/env_loaded.dart';
import 'package:album/events/infra_loaded.dart';
import 'package:album/events/repository_loaded.dart';
import 'package:album/events/service_loaded.dart';
import 'package:album/firebase_options.dart';
import 'package:album/repositories/auth.dart';
import 'package:album/repositories/image.dart';
import 'package:album/services/client/client.dart';
import 'package:album/utils/debug.dart';
import 'package:album/utils/dependency.dart';
import 'package:codux/codux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BootstrapEffects extends Effect {
  BootstrapEffects() {
    on<AppStarted>((event) async {
      await dotenv.load();

      Debug.log("Environment initialized");

      dispatch(const EnvLoaded());
    });
    on<EnvLoaded>((event) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      Debug.log("Infrastructure initialized");

      dispatch(const InfraLoaded());
    });
    on<InfraLoaded>((event) {
      Dependency.assign<AuthRepository>(AuthRepository());
      Dependency.assign<ImageRepository>(ImageRepository());

      Debug.log("Repository dependencies assigned");

      dispatch(const RepositoryLoaded());
    });
    on<RepositoryLoaded>((event) {
      Dependency.assign<Client>(Client());

      Debug.log("Service dependencies assigned");

      dispatch(const ServiceLoaded());
    });
  }
}
