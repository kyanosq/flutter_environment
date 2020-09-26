import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:quiver/iterables.dart';

abstract class HTTPServiceType {
  Locale locale;
  String token;
  String baseUrl;
  LogMode logMode;
  Dio client;

  bool get isLoggedIn;

  HTTPServiceType(
      {@required this.locale,
      @required this.baseUrl,
      LogMode logMode,
      String token});

  HTTPServiceType login(String token);

  HTTPServiceType logout();

  HTTPServiceType update({
    String token,
    Locale locale,
    String baseUrl,
    LogMode logMode,
  });

  HTTPServiceType copyWith({
    String token,
    Locale locale,
    String baseUrl,
    LogMode logMode,
  });

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  });

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });
}

enum LogMode { none, normal, verbose }

class HTTPService implements HTTPServiceType {
  HTTPService(
      {@required this.locale,
      @required this.baseUrl,
      LogMode logMode,
      String token})
      : this.logMode = logMode ?? LogMode.none,
        this.token = token ?? '' {
    final language = this.locale?.languageCode ?? '';
    var headers = {'Accept-Language': language};
    if (isNotEmpty(this.token)) {
      headers['Authorization'] = this.token;
    }
    final client = Dio(BaseOptions(
        baseUrl: this.baseUrl,
        headers: headers,
        connectTimeout: 15000,
        validateStatus: (code) => range(200, 399).contains(code)));

    if (logMode == LogMode.normal) {
      client.interceptors.add(LogInterceptor());
    } else if (logMode == LogMode.verbose) {
      client.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    client.interceptors..add(AuthorizationInterceptor());
    // ..add(ResponseChecker()); //使用transformer实现
    this.client = client;
  }

  @override
  Locale locale;

  @override
  String token;

  @override
  Dio client;

  @override
  LogMode logMode;

  @override
  String baseUrl;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) {
    return client.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) {
    return client.post(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  @override
  HTTPService login(String token) {
    return update(token: token);
  }

  @override
  HTTPService logout() {
    return update(token: "");
  }

  HTTPService update({
    String token,
    Locale locale,
    String baseUrl,
    LogMode logMode,
  }) {
    return copyWith(
      locale: locale,
      token: token,
      baseUrl: baseUrl,
      logMode: logMode,
    );
  }

  HTTPService copyWith({
    String token,
    Locale locale,
    String baseUrl,
    LogMode logMode,
  }) {
    return HTTPService(
      baseUrl: baseUrl ?? this.baseUrl,
      locale: locale ?? this.locale,
      token: token ?? this.token,
      logMode: logMode ?? this.logMode,
    );
  }

  @override
  bool get isLoggedIn => token != null && token.isNotEmpty;
}

class AuthorizationInterceptor extends Interceptor {
  @override
  Future onError(DioError err) async {
    if (err?.response?.statusCode == 401) {
      // EnvironmentManager.logout();
    }
    return err; //ErrorEnvelope(err);
  }
}

class ResponseChecker extends Interceptor {
  @override
  Future onResponse(Response response) {
    if (response.data is String) {
      throw DioError(
          response: response,
          type: DioErrorType.RESPONSE,
          error: response.data);
    }
    final data = response.data as Map<String, dynamic>;
    final code = data['code'] as int ?? 0;
    if (code == 0) {
      return Future<dynamic>.value(response);
    } else {
      var message = data['message'] as String;
      if (isEmpty(message)) {
        message = '错误 code :$code';
      }
      throw DioError(
          response: response, type: DioErrorType.RESPONSE, error: message);
    }
  }
}
