import 'package:example_flutter/AppBLoC/app_bloc.dart';
import 'package:example_flutter/AppBLoC/bloc.dart';
import 'package:example_flutter/Decode/apk_decoder_screen.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Builder/BuilderBLoC/builder_bloc.dart';
import 'Builder/apk_builder_screen.dart';
import 'Decode/DecoderBLoC/bloc.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APK Dissolver',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          color: Colors.white,
          elevation: 3,
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: MyHomePage(),
    );
  }
}

///
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AppBloc appBloc = AppBloc();
  final DecoderBloc decoderBloc = DecoderBloc();
  final BuilderBloc builderBloc = BuilderBloc();

  @override
  void dispose() {
    super.dispose();
    appBloc.close();
    decoderBloc.close();
    builderBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: const <Widget>[
            Tab(
              text: 'Decode',
            ),
            Tab(
              text: 'Build',
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            BlocProvider.value(
              value: decoderBloc,
              child: APKDecoder(),
            ),
            BlocProvider.value(
              value: builderBloc,
              child: APKBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
