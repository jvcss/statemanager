
class API {
  String? dateAndTime;

  Future<String> getDateAndTime() async {
    // Simulate network request
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        return dateAndTime = DateTime.now().toLocal().toString();
      },
    ).then((value) {
      dateAndTime = DateTime.now().toLocal().toString();
    });

    return dateAndTime!;
  }
}
