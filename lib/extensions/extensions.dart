extension TrimmedCaseInsensitiveContains
    on String {
  /// Checks if the string contains another 
  /// string in a case-insensitive manner
  /// after trimming both strings.
  bool trimmedCaseInsensitiveContains(
      String other) {
    return this
        .trim()
        .toLowerCase()
        .contains(other.trim().toLowerCase());
  }
}
