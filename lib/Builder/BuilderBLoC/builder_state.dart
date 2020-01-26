import 'package:equatable/equatable.dart';

///
abstract class BuilderState extends Equatable {
  ///
  const BuilderState();
}

///
class InitialBuilderState extends BuilderState {
  @override
  List<Object> get props => [];
}

///
class GotOutputPath extends BuilderState {
  /// outputs the path of the apk requirements
  const GotOutputPath({this.path});

  /// path of the resources
  final String path;

  @override
  List<Object> get props => [];
}

///
class StartBuilding extends BuilderState {
  @override
  List<Object> get props => [];
}

/// B stands for Build
class FinishAPKToolBCall extends BuilderState {
  ///
  const FinishAPKToolBCall({this.stdout});

  /// output from CMD
  final String stdout;

  @override
  List<Object> get props => [];
}

/// generating assigning key
class FinishGenKey extends BuilderState {
  ///
  const FinishGenKey({this.stdout});

  /// output from CMD
  final String stdout;

  @override
  List<Object> get props => [];
}

/// unnecessary build file deletion done
class FinishDeletingBuild extends BuilderState {
  ///
  const FinishDeletingBuild({this.stdout});

  /// output from CMD
  final String stdout;

  @override
  List<Object> get props => [];
}

/// move the produced apk to the main directory of the project
class FinishMovingAPK extends BuilderState {
  ///
  const FinishMovingAPK({this.stdout});

  /// output from CMD
  final String stdout;

  @override
  List<Object> get props => [];
}

/// move the produced apk to the main directory of the project
class FinishedSigning extends BuilderState {
  ///
  const FinishedSigning({this.stdout});

  /// output from CMD
  final String stdout;

  @override
  List<Object> get props => [];
}

/// move the produced apk to the main directory of the project
class FinishedAligning extends BuilderState {
  ///
  const FinishedAligning({this.stdout});

  /// output from CMD
  final String stdout;

  @override
  List<Object> get props => [];
}