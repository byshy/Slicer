import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

/// main BLoC for the app
class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {}

}