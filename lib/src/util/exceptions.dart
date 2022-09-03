/// Exception thrown usually when out of range page
class NoSubjectsException implements Exception {
  String? message;
  NoSubjectsException({this.message});
}

/// Exception thrown when the body is empty, indicates that the subject not
/// offered at all, so nothing to parse
class EmptyBodyException implements Exception {
  String? message;
  EmptyBodyException({this.message});
}
