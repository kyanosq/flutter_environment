import 'dart:async';
import 'package:environment/app_bloc.dart';
import 'package:environment/app_event.dart';
import 'package:environment/app_state.dart';
import 'package:environment/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/strings.dart';

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  runZonedGuarded(() => runApp(MyApp()), (Object error, StackTrace stackTrace) {
    print('Error $error');
  });
}

class MyApp extends StatefulWidget {
  final _serviceProviderKey =
      GlobalKey<ServiceProviderState>(debugLabel: 'ServiceProviderState');
  final _navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'ServiceProviderState');

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NavigatorState get _navigator => widget._navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    print(context);
    return ServiceProvider(
        key: widget._serviceProviderKey,
        create: (service) => MultiBlocProvider(
              providers: [
                BlocProvider<AppBloc>(
                  create: (_) => AppBloc(service)..add(AppStarted()),
                ),
              ],
              child: BlocBuilder<AppBloc, AppState>(
                buildWhen: (previous, current) {
                  return true;
                },
                builder: (context, state) {
                  return MaterialApp(
                    navigatorKey: widget._navigatorKey,
                    title: 'Example',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
                    builder: (context, child) {
                      return BlocListener<AppBloc, AppState>(
                        listenWhen: (previous, current) {
                          return true;
                        },
                        listener: (context, state) {
                          if (state is AppInitialized) {
                            if (isEmpty(state.token)) {
                              _navigator.pushAndRemoveUntil<void>(
                                  HomePage.route(), (route) => false);
                            } else {
                              _navigator.pushAndRemoveUntil<void>(
                                  HomePage.route(), (route) => false);
                            }
                          }
                        },
                        child: child,
                      );
                    },
                    onGenerateRoute: (_) => HomePage.route(),
                    // routes: {},
                  );
                },
              ),
            ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: FlatButton(onPressed: () {}, child: Text('获取')),
      ),
    );
  }
}
