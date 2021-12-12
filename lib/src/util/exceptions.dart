class NoSubjectsException implements Exception {
  String? message;
  NoSubjectsException({this.message});
}

class EmptyBodyException implements Exception {
  String? message;
  EmptyBodyException({this.message});
}
