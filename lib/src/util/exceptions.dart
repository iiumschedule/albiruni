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

/// Unable to pasre the day and time given by the server
///
/// Refer issue: https://github.com/iqfareez/albiruni/issues/1
class DayTimeParseException implements Exception {
  String? message;
  DayTimeParseException({this.message});
}
