enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get url {
    switch (this) {
      case PersonUrl.person1:
        return 'https://jsonplaceholder.typicode.com/users/1';
      case PersonUrl.person2:
        return 'https://jsonplaceholder.typicode.com/users/2';
    }
  }
}
