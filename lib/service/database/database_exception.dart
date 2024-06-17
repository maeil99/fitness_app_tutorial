class ErrorGetDocumentDirectory implements Exception {}

class ErrorDbNotOpen implements Exception {}

class FailedOpenDatabase implements Exception {
  final dynamic error;
  FailedOpenDatabase(this.error);
}
