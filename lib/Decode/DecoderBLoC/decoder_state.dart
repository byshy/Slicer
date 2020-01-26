import 'package:equatable/equatable.dart';

///
abstract class DecoderState extends Equatable {
  ///
  const DecoderState();
}

///
class InitialDecoderState extends DecoderState {
  @override
  List<Object> get props => [];
}

/// called after fetching APK
class GotAPK extends DecoderState {
  /// outputs the path of the apk
  const GotAPK({this.path});

  /// path of the specified APK
  final String path;

  @override
  List<Object> get props => [];
}

///
class StartDissolve extends DecoderState {
  @override
  List<Object> get props => [];
}

/// D stands for Decode
class FinishAPKToolDCall extends DecoderState {
  ///
  const FinishAPKToolDCall({this.stdout});

  /// output from CMD
  final String stdout;

  @override
  List<Object> get props => [];
}

///
class FinishCopyAPK2Dest extends DecoderState {
  ///
  const FinishCopyAPK2Dest({this.stdout});

  /// output from CMD
  final String stdout;
  @override
  List<Object> get props => throw UnimplementedError();
}

///
class FinishConvert2ZIP extends DecoderState {
  ///
  const FinishConvert2ZIP({this.stdout});

  /// output from CMD
  final String stdout;
  @override
  List<Object> get props => throw UnimplementedError();
}

///
class FinishGetDex extends DecoderState {
  ///
  const FinishGetDex({this.stdout});

  /// output from CMD
  final String stdout;
  @override
  List<Object> get props => throw UnimplementedError();
}

///
class FinishCallDEX2JAR extends DecoderState {
  ///
  const FinishCallDEX2JAR({this.stdout});

  /// output from CMD
  final String stdout;
  @override
  List<Object> get props => throw UnimplementedError();
}

///
class FinishMoveJAR extends DecoderState {
  ///
  const FinishMoveJAR({this.stdout});

  /// output from CMD
  final String stdout;
  @override
  List<Object> get props => throw UnimplementedError();
}

///
class FinishDeleteError extends DecoderState {
  ///
  const FinishDeleteError({this.stdout});

  /// output from CMD
  final String stdout;
  @override
  List<Object> get props => throw UnimplementedError();
}