import 'package:album/infrastructure/services/client/client.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:album/utilities/dependency.dart';
import 'package:codux/codux.dart';

typedef Request = Future<Response> Function(Client client);

mixin ClientEffectMixin on Effect {
  Future<Response> useClient(Request request) async {
    final client = Dependency.find<Client>();

    try {
      final result = await request(client);

      return result;
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 5000));

      return useClient(request);
    }
  }
}
