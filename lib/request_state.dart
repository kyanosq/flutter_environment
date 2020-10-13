
abstract class RequestState {}

class RequestStateRequesting extends RequestState {
  final double progress;

  RequestStateRequesting({this.progress});
}

class RequestStateFailure extends RequestState {
  final dynamic error;

  RequestStateFailure(this.error);
}

class RequestStateSuccess extends RequestState {
  final dynamic data;

  RequestStateSuccess(this.data);
}