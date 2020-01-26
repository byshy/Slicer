import 'package:example_flutter/Decode/DecoderBLoC/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
class APKDecoder extends StatefulWidget {
  @override
  _APKDecoderState createState() => _APKDecoderState();
}

class _APKDecoderState extends State<APKDecoder> {
  DecoderBloc decoderBloc;
  final TextEditingController apkPath = TextEditingController();
  String result = '';
  String newName = '';
  String name = '';
  String dex2jarPath = 'C:\\Users\\byshy\\Desktop\\d2j';
  bool isStarted = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    decoderBloc = BlocProvider.of<DecoderBloc>(context);
    apkPath.text = decoderBloc.apkPath ?? '';
    result = decoderBloc.output ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: decoderBloc,
      listener: (_, state) {
        if (state is GotAPK) {
          setState(() {
            apkPath.text = state.path;
            formKey.currentState.validate();
          });
        } else if (state is StartDissolve) {
          setState(() {
            result = '$result\nStart';
            isStarted = true;
          });
        } else if (state is FinishAPKToolDCall) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishCopyAPK2Dest) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishConvert2ZIP) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishGetDex) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishCallDEX2JAR) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishMoveJAR) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishDeleteError) {
          setState(() {
            result = state.stdout;
            isStarted = false;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'APK Path',
                      ),
                      controller: apkPath,
                      validator: (value){
                        if (value.isEmpty) {
                          return 'Please enter the path of APK';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add APK'),
                  onPressed: () {
                    decoderBloc.add(GetAPK());
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: isStarted
                  ? null
                  : () {
                      if(formKey.currentState.validate()){
                        final oldName = apkPath.text.trim().split('\\').last;
                        decoderBloc.add(CallAPKToolD(
                          oldName: oldName,
                          dex2jarPath: dex2jarPath,
                        ));
                      }
                    },
              child: Text('Start'),
            ),
            SizedBox(
              height: 5,
            ),
            Visibility(
                visible: isStarted,
                child: Column(
                  children: <Widget>[
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: LinearProgressIndicator(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    Text(result),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
