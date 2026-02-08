mixin LoggerMixin {
  void log(String action, String message) {
    final timestamp = DateTime.now().toIso8601String();
    print('[$timestamp] $action: $message');
  }
}

mixin ValidatableMixin {
  void validateName(String name) {
    if (name.trim().isEmpty) {
      throw ArgumentError('Name cannot be empty.');
    }
  }
}

mixin TrackableMixin {
  final List<String> history = [];

  void track(String event) {
    final timestamp = DateTime.now().toIso8601String();
    history.add('$timestamp - $event');
  }
}
