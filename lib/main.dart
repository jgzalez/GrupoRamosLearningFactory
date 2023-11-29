import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'Content.dart';
import 'LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variable para mantener el widget actual del contenido principal
  Widget _contentWidget = ContentWidgetOne();

  // Método para cambiar el contenido
  void _changeContent(Widget newWidget) {
    setState(() {
      _contentWidget = newWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar estático
          Expanded(
            flex: 2,
            child: CustomDrawer(onSelectContent: _changeContent),
          ),
          // Contenido principal
          Expanded(
            flex: 8,
            child: _contentWidget,
          ),
        ],
      ),
    );
  }
}
