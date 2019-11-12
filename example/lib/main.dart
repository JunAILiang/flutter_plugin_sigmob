import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_sigmob/flutter_plugin_sigmob.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  FlutterPluginSigmob sigmob;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPluginSigmob.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    sigmob = FlutterPluginSigmob(listener: (SigmobEvents events, Map<String, dynamic> args) {
      print("我走进了回调" + events.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  FlutterPluginSigmob.init("2112", "34aa76669c7379f9");
                },
                child: Text("初始化"),
              ),
              RaisedButton(
                onPressed: () {
                   sigmob.loadVideo("e4fac6a412b");
                },
                child: Text("加载"),
              ),
              RaisedButton(
                onPressed: () {
                  sigmob.showVideo("e4fac6a412b");
                },
                child: Text("显示"),
              ),
            ],
          )
        ),
      ),
    );
  }
}
