class Dependency {
  static final Map<String, dynamic> _manifest = {};

  static void assign<T>(T instance) {
    final key = T.toString();

    _manifest[key] = instance;
  }

  static T inject<T>() {
    final key = T.toString();

    final result = _manifest[key];

    assert(result != null, "$T is not found");

    return result as T;
  }
}
