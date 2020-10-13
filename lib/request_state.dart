
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

typedef RequestDataWidgetBuilder = Widget Function(
    BuildContext context, dynamic data);

typedef RequestLoadingWidgetBuilder = Widget Function(
    BuildContext context,
    double progress,
    );

typedef RequestErrorWidgetBuilder = Widget Function(
    BuildContext context,
    dynamic error,
    );