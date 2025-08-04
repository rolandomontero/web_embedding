import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:js/js.dart' as js;
import 'package:js/js_util.dart' as js_util;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

@js.JSExport()
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _streamController = StreamController<void>.broadcast();

  @override
  void initState() {
    super.initState();

    // Exportar el estado a JavaScript
    final export = js_util.createDartExport(this);
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod<void>(js_util.globalThis, '_stateSet', []);
  }

  @js.JSExport()
  void increment() {
    setState(() {
      _counter++;
      // Notificar a los observadores
      _streamController.add(null);
    });
  }

  @js.JSExport()
  void addHandler(void Function() handler) {
    _streamController.stream.listen((event) => handler());
  }

  @js.JSExport()
  int get count => _counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up any resources if necessary
    // For example, you might want to remove event listeners or cancel timers
  }
}
