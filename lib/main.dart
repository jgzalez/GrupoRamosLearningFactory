import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/LoginPage.dart';
import 'firebase_options.dart'; // Asegúrate de que esta línea esté presente y sea correcta
import 'Componentes/Sidebar/sidebar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:
          LoginScreen(), // Ensure you have a 'home' or properly set up 'routes'.
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
