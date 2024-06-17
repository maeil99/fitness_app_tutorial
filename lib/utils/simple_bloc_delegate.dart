import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint("bloc onEvent: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint("cubit onError: $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint("bloc onTransition: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint("cubit onChange: $change");
    super.onChange(bloc, change);
  }
}
