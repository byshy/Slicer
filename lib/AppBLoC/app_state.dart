import 'package:equatable/equatable.dart';

/// main BLoC state for the app
abstract class AppState extends Equatable {
  ///
  const AppState();
}

///
class InitialAppState extends AppState {
  @override
  List<Object> get props => [];
}