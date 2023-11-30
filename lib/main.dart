import 'package:flutter/material.dart';
import 'Componentes/Sidebar/sidebar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:
          MyHomePage(), // Ensure you have a 'home' or properly set up 'routes'.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _contentWidget =
      Center(child: Text('Contenido Principal')); // Contenido por defecto

  void _changeContent(Widget newContentWidget) {
    if (_contentWidget.key != newContentWidget.key) {
      setState(() {
        _contentWidget = newContentWidget;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomDrawer(onSelectContent: _changeContent),
          ),
          Expanded(
            flex: 8,
            child: _contentWidget,
          ),
        ],
      ),
    );
  }
}
