class ErrorWrapper {
  final dynamic error;

  final String prompt;
  final String message;

  ErrorWrapper({this.error, this.prompt, this.message})
      : assert((error != null || prompt != null || message != null));
}
