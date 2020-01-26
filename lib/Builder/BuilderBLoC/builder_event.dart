import 'package:equatable/equatable.dart';

///
abstract class BuilderEvent extends Equatable {
  ///
  const BuilderEvent();
}

/// retrieves the apk requirements path (which is the same as the output path)
class GetOutputPath extends BuilderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// start APK tool (B for Build)
class CallAPKToolB extends BuilderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

///
class DeleteBuildFile extends BuilderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

///
class MoveAPK extends BuilderEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

/// generate the signing key for the produced app
class GenKey extends BuilderEvent {
  ///
  const GenKey(
      {this.name,
      this.orgUnit,
      this.org,
      this.city,
      this.state,
      this.country,
      this.alias,
      this.aliasPass,
      this.aliasYears,
      this.target,
      this.storePass});

  /// user name
  final String name;
  /// organization unit
  final String orgUnit;
  /// organization name
  final String org;
  ///
  final String city;
  ///
  final String state;
  ///
  final String country;
  ///
  final String alias;
  ///
  final String aliasPass;
  /// validity of keystore
  final int aliasYears;
  /// target path
  final String target;
  ///
  final String storePass;

  @override
  List<Object> get props => throw UnimplementedError();
}

///
class APKSign extends BuilderEvent {
  ///
  const APKSign({this.keystorePath, this.storepass, this.aliasPass, this.targetPath, this.alias});

  ///
  final String keystorePath;
  ///
  final String storepass;
  ///
  final String aliasPass;
  ///
  final String targetPath;
  ///
  final String alias;

  @override
  List<Object> get props => throw UnimplementedError();
}

///
class APKAlignment extends BuilderEvent {
  ///
  const APKAlignment({this.inputAPK, this.outputAPK});

  ///
  final String inputAPK;
  ///
  final String outputAPK;

  @override
  List<Object> get props => throw UnimplementedError();
}
