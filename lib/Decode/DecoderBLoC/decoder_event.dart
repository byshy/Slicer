import 'package:equatable/equatable.dart';

///
abstract class DecoderEvent extends Equatable {
  ///
  const DecoderEvent();
}

/// retrieves the apk path
class GetAPK extends DecoderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// start APK tool (D for Decode)
class CallAPKToolD extends DecoderEvent {
  /// these parameters need to be passed only once, then will be copied inside
  /// the bloc and processed
  const CallAPKToolD({this.oldName, this.dex2jarPath});

  /// full application (with .apk)
  final String oldName;
  /// directory of the dex2jar tool
  final String dex2jarPath;

  @override
  List<Object> get props => throw UnimplementedError();
}

/// Copy2Dest: create a copy from the apk inside the directory of the project
class Copy2Dest extends DecoderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// Convert2ZIP: converts from *.apk to *.zip
class Convert2ZIP extends DecoderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// GetDEX: extract the classes.dex file from the *.zip file
class GetDEX extends DecoderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// CallDEX2JAR
class CallDEX2JAR extends DecoderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// MoveJAR: moves the newly produced JAR file from the D2J directory to the
/// current project directory
class MoveJAR extends DecoderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// DeleteError: deletes the error file generated from the d2j-dex2jar.bat,
/// you should not worry about it as it seems a bug in the utility, the JARs
/// the are produced are perfectly fine.
class DeleteError extends DecoderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}