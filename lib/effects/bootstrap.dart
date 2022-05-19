import 'package:album/events/app_started.dart';
import 'package:album/events/bootstrap/bootstrap_finished.dart';
import 'package:album/events/bootstrap/env_loaded.dart';
import 'package:album/events/bootstrap/infra_loaded.dart';
import 'package:album/events/bootstrap/repository_loaded.dart';
import 'package:album/events/bootstrap/service_loaded.dart';
import 'package:album/firebase_options.dart';
import 'package:album/repositories/auth.dart';
import 'package:album/repositories/image.dart';
import 'package:album/services/client/client.dart';
import 'package:album/utils/dependency.dart';
import 'package:codux/codux.dart';
import 'package:firebase_core/firebase_core.dart';
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
      Dependency.assign<AuthRepository>(AuthRepository());
      Dependency.assign<ImageRepository>(ImageRepository());

      dispatch(const RepositoryLoaded());
    });
    on<RepositoryLoaded>((event) {
      Dependency.assign<ClientService>(ClientService());

      dispatch(const ServiceLoaded());
    });
    on<ServiceLoaded>((event) {
      dispatch(const AppReady());
    });
  }
}
