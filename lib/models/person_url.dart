enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get url {
    switch (this) {
      case PersonUrl.person1:
        return 'http://10.0.2.2:5500/api/persons1.json';
      case PersonUrl.person2:
        return 'http://10.0.2.2:5500/api/persons2.json';//https://jsonplaceholder.typicode.com/users/2
    }
  }
}
