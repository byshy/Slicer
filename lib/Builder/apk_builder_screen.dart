import 'package:example_flutter/Builder/BuilderBLoC/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
class APKBuilder extends StatefulWidget {
  @override
  _APKBuilderState createState() => _APKBuilderState();
}

class _APKBuilderState extends State<APKBuilder> {
  BuilderBloc builderBloc;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController outputPath = TextEditingController();
  bool isStarted = false;
  String result = '';

  @override
  void initState() {
    super.initState();
    builderBloc = BlocProvider.of<BuilderBloc>(context);
    outputPath.text = builderBloc.outputPath ?? '';
    result = builderBloc.output ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: builderBloc,
      listener: (_, state) {
        if (state is GotOutputPath) {
          setState(() {
            outputPath.text = state.path;
            formKey.currentState.validate();
          });
        } else if (state is StartBuilding) {
          setState(() {
            result = '$result\nStart';
            isStarted = true;
          });
        } else if (state is FinishAPKToolBCall) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishGenKey) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishDeletingBuild) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishMovingAPK) {
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishedSigning){
          setState(() {
            result = state.stdout;
          });
        } else if (state is FinishedAligning){
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
                      controller: outputPath,
                      validator: (value) {
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
                  label: Text('Add Path'),
                  onPressed: () {
                    builderBloc.add(GetOutputPath());
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
                      if (formKey.currentState.validate()) {
                        builderBloc.add(CallAPKToolB());
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
