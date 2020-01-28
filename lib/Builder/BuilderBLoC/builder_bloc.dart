import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import './bloc.dart';

/// BLoC for builder portion of the app
class BuilderBloc extends Bloc<BuilderEvent, BuilderState> {
  @override
  BuilderState get initialState => InitialBuilderState();

  /// path of the produced apk file
  String outputPath = '';

  /// stdout log
  String output = '';

  ///
  String apkName = '';

  @override
  Stream<BuilderState> mapEventToState(
    BuilderEvent event,
  ) async* {
    if (event is GetOutputPath) {
      final result = await Process.run(
        'folder_chooser.bat',
        [],
        runInShell: true,
        workingDirectory:
            'C:\\Users\\byshy\\AndroidStudioProjects\\flutter-desktop-embedding-master\\example\\lib',
      );
      outputPath = result.stdout.toString().trim();

      apkName = outputPath.split('\\').last;

      yield GotOutputPath(path: outputPath);

      /// the following line is important when a user closes the file selection
      /// window without choosing anything, if he/she then open it again and
      /// select a file, the file will not be displayed as the bloc listener
      /// will not recognize that the state changed, so the following line
      /// resets the state
      yield InitialBuilderState();
    } else if (event is CallAPKToolB) {
      yield StartBuilding();

      output = '$output\nStart';

      final result = await Process.run(
        'apktool',
        ['b', outputPath],
        runInShell: true,
        workingDirectory: 'C:\\Users\\byshy\\Desktop\\APKDissolverOut',
      );
      output = '$output\n${result.stdout}';
      yield FinishAPKToolBCall(stdout: output);

      add(DeleteBuildFile());
    } else if (event is DeleteBuildFile) {
      final result = await Process.run(
        'rd',
        ['/s', '/q', '$outputPath\\build'],
        runInShell: true,
      );

      output = '$output\n${result.stdout}';
      yield FinishDeletingBuild(stdout: output);
      add(MoveAPK());
    } else if (event is MoveAPK) {
      final result = await Process.run(
        'move',
        ['$outputPath\\dist\\$apkName.apk', outputPath],
        runInShell: true,
      );

      output = '$output\n${result.stdout}';
      yield FinishMovingAPK(stdout: output);

      await Process.run(
        'rd',
        ['/s', '/q', '$outputPath\\dist'],
        runInShell: true,
      );
//      add(GenKey());
      add(
        GenKey(
          storePass: 'storePass',
          alias: 'alias',
          aliasPass: 'aliasPass',
          aliasYears: 25 * 365,
          name: 'coname',
          org: 'org',
          state: 'state',
          orgUnit: 'orgUnit',
          city: 'city',
          country: 'country',
          target:
              'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$apkName\\ks.keystore',
        ),
      );
    } else if (event is GenKey) {
      var dName = '';
      if (event.name.isNotEmpty) {
        dName = '${dName}CN=${event.name} ';
      }
      if (event.orgUnit.isNotEmpty) {
        dName = '${dName}OU=${event.orgUnit} ';
      }
      if (event.org.isNotEmpty) {
        dName = '${dName}O=${event.org} ';
      }
      if (event.city.isNotEmpty) {
        dName = '${dName}L=${event.city} ';
      }
      if (event.state.isNotEmpty) {
        dName = '${dName}S=${event.state} ';
      }
      if (event.country.isNotEmpty) {
        dName = '${dName}C=${event.country}';
      }
      dName = dName.trim();

      final result = await Process.run(
        'keytool',
        [
          '-genkey',
          '-keyalg',
          'RSA',
          '-alias',
          event.alias,
          '-keypass',
          event.aliasPass,
          '-validity',
          event.aliasYears.toString(),
          '-keystore',
          event.target,
          '-storepass',
          event.storePass,
          '-genkeypair',
          '-dname',
          dName,
        ],
        runInShell: true,
        workingDirectory: 'C:\\Program Files\\Java\\jdk1.8.0_221\\bin',
      );

      final out = result.stdout.toString().isEmpty
          ? 'done creating keystore file'
          : result.stdout;
      output = '$output\n$out';
      yield FinishGenKey(stdout: output);

      // TODO: use the outputPath -> *.keystore (name the key with the directory name)
      add(
        APKSign(
            alias: 'alias',
            aliasPass: 'aliasPass',
            storepass: 'storePass',
            targetPath:
                'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$apkName\\$apkName.apk',
            keystorePath:
                'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$apkName\\ks.keystore'),
      );
    } else if (event is APKSign) {
      final result = await Process.run(
        'jarsigner',
        [
          '-keystore',
          event.keystorePath,
          '-digestalg',
          'SHA1',
          '-storepass',
          event.storepass,
          '-keypass',
          event.aliasPass, // alias password
          event.targetPath,
          event.alias,
        ],
        runInShell: true,
        workingDirectory: 'C:\\Program Files\\Java\\jdk1.8.0_221\\bin',
      );

      final out = result.stdout.toString().isEmpty
          ? 'done signing the apk'
          : result.stdout;
      output = '$output\n$out';
      yield FinishedSigning(stdout: output);
      add(
        APKAlignment(
            outputAPK:
                'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$apkName\\${apkName}_DONE.apk',
            inputAPK:
                'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$apkName\\$apkName.apk'),
      );
    } else if (event is APKAlignment) {
      final result = await Process.run(
        'zipalign',
        ['4', event.inputAPK, event.outputAPK],
        runInShell: true,
        workingDirectory:
            'C:\\Users\\byshy\\AppData\\Local\\Android\\Sdk\\build-tools\\29.0.2',
      );

      final out = result.stdout.toString().isEmpty
          ? 'done aligning the apk'
          : result.stdout;
      output = '$output\n$out';
      yield FinishedAligning(stdout: output);
    }
  }
}
