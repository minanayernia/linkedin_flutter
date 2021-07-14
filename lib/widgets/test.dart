

import 'package:flutter/material.dart';
import 'dart:async';

class StatefullWidgetDemo extends StatefulWidget {
  @override
  _StatefulWidgetDemoState createState() {
    return new _StatefulWidgetDemoState();
  }
}

class _StatefulWidgetDemoState extends State<StatefullWidgetDemo> {
  String _textFromFile = "";

  _StatefulWidgetDemoState() {
    getTextFromFile().then((val) => setState(() {
      print("boooooz");
          _textFromFile = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Stateful Demo'),
      ),
      body: new SingleChildScrollView(
        padding: new EdgeInsets.all(8.0),
        child: new Text(
          _textFromFile,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }

  Future<String> getFileData(String path) async {
    return "your data from file";
  }

  Future<String> getTextFromFile() async {
    return await getFileData("test.txt");
  }
}