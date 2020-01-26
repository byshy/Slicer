import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import './bloc.dart';

/// BLoC for decoder portion of the app
class DecoderBloc extends Bloc<DecoderEvent, DecoderState> {
  @override
  DecoderState get initialState => InitialDecoderState();

  /// name of the app (without .apk or .zip)
  String name = '';
  /// name of the app (with .zip)
  String newName = '';
  /// directory of the dex2jar tool
  String dex2jarPath = '';
  /// location of the APK
  String apkPath = '';
  /// stdout log
  String output = '';

  @override
  Stream<DecoderState> mapEventToState(
    DecoderEvent event,
  ) async* {
    if(event is GetAPK){
      final result = await Process.run(
        'file_chooser.bat', [],
        runInShell: true,
        workingDirectory:
        'C:\\Users\\byshy\\AndroidStudioProjects\\flutter-desktop-embedding-master\\example\\lib',
      );
      apkPath = result.stdout.toString().trim();
      yield GotAPK(path: apkPath);

      /// the following line is important when a user closes the file selection
      /// window without choosing anything, if he/she then open it again and
      /// select a file, the file will not be displayed as the bloc listener
      /// will not recognize that the state changed, so the following line
      /// resets the state
      yield InitialDecoderState();
    } else if(event is CallAPKToolD){
      yield StartDissolve();

      output = '$output\nStart';

      final result = await Process.run(
        'apktool',
        ['d', apkPath],
        runInShell: true,
        workingDirectory: 'C:\\Users\\byshy\\Desktop\\APKDissolverOut',
      );

      name = event.oldName.substring(0, event.oldName.length - 4);
      newName = '$name.zip';
      dex2jarPath = event.dex2jarPath;

      output = '$output\n${result.stdout}';
      yield FinishAPKToolDCall(stdout: output);
      add(Copy2Dest());
    } else if (event is Copy2Dest){

      final result = await Process.run(
        'copy',
        [apkPath],
        runInShell: true,
        workingDirectory: 'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$name',
      );

      output = '$output\n${result.stdout}';
      yield FinishCopyAPK2Dest(stdout: output);
      add(Convert2ZIP());
    } else if (event is Convert2ZIP){
      final result = await Process.run(
        'ren',
        ['$name.apk', newName],
        runInShell: true,
        workingDirectory: 'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$name',
      );

      output = '$output\n${result.stdout}';
      yield FinishConvert2ZIP(stdout: output);

      add(GetDEX());
      add(CallDEX2JAR());
    } else if (event is GetDEX){
      final bytes = File('C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$name\\$newName').readAsBytesSync();

      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filename = file.name;
        if (filename == 'classes.dex') {
          final List<int> data = file.content;
          File('C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$name\\$filename')
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
          break;
        }
      }

      output = '$output\nfinished getting DEX file';
      yield FinishGetDex(stdout: output);
    } else if (event is CallDEX2JAR){
      final result = await Process.run(
        'd2j-dex2jar.bat',
        ['C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$name\\classes.dex'],
        runInShell: true,
        workingDirectory: dex2jarPath,
      );

      output = '$output\n${result.stdout}';
      yield FinishCallDEX2JAR(stdout: output);
      add(MoveJAR());
    } else if (event is MoveJAR){
      final result = await Process.run(
        'move',
        ['$dex2jarPath\\classes-dex2jar.jar', 'C:\\Users\\byshy\\Desktop\\APKDissolverOut\\$name'],
        runInShell: true,
      );

      output = '$output\n${result.stdout}';
      yield FinishMoveJAR(stdout: output);
      add(DeleteError());
    } else if (event is DeleteError){
      final result = await Process.run(
        'del',
        ['$dex2jarPath\\classes-error.zip'],
        runInShell: true,
      );

      output = '$output\n${result.stdout}\n---------------------------------------------------------------------------------';
      yield FinishDeleteError(stdout: output);
    }
  }
}
