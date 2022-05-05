import 'package:album/core/locator/service.dart';

final Map<String, Locator> locatorManifest = {};

class Locator {
  final Map<String, Service> _manifest = {};

  Locator(List<Service> services) {
    for (final service in services) {
      _manifest[service.key] = service;
    }
  }

  static T of<T>([String context = "global"]) {
    final locator = locatorManifest[context];

    if (locator == null) {
      throw Exception("Locator $context not found");
    }

    final key = T.toString();

    final service = locator._manifest[key];

    if (service == null) {
      throw Exception("$T not found");
    }

    return service.require();
  }
}