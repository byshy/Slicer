import 'package:example_flutter/AppBLoC/app_bloc.dart';
import 'package:example_flutter/AppBLoC/bloc.dart';
import 'package:example_flutter/Decode/apk_decoder_screen.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_utils/window_utils.dart';

import 'Builder/BuilderBLoC/builder_bloc.dart';
import 'Builder/apk_builder_screen.dart';
import 'Decode/DecoderBLoC/bloc.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

///
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => WindowUtils.hideTitleBar(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2
        )
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Slicer',
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
      ),
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTapDown: (_) => WindowUtils.startDrag(),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text('Slicer'),
                  leading: Icon(
                    Icons.android,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                right: 40,
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: WindowUtils.minWindow,
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: WindowUtils.closeWindow,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.grey[100],
                elevation: 6,
                child: TabBar(
                  tabs: const <Widget>[
                    Tab(
                      text: 'Decode',
                    ),
                    Tab(
                      text: 'Build',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
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
          ],
        ),
      ),
    );
  }
}
