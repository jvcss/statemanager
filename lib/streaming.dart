
Stream<String> getTime() => Stream.periodic(const Duration(seconds: 1), (i) => DateTime.now().toLocal().toString());
