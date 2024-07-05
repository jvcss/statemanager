
class LoadingScreen {
  LoadingScreen._singleton(); 
  static LoadingScreen? _instance;
  factory LoadingScreen() {
    _instance ??= LoadingScreen._singleton(); 
    return _instance!;
  }
}
