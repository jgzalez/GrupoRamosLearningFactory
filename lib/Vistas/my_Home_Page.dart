import 'package:flutter/material.dart';
import 'package:frontend/Controladores/authService.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/EstablishmentPage.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/LoginPage.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/ModelsPage.dart'; // Asegúrate de que esta ruta sea correcta

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var data = await AuthService().obtenerDatosUsuario();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Página Principal'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    String imageUrl = userData?['profileImage'] ?? 'url_imagen_por_defecto';
    String name = userData?['name'] ?? 'Nombre no disponible';
    String role = userData?['role'] ?? 'Rol no disponible';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 50.0,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 10),
                Text(name,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(role, style: TextStyle(fontSize: 16, color: Colors.grey)),
                Divider(),
                _buildButtonBar(),
              ],
            ),
          ),
        ),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildButtonBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildSquareButton('Establecimientos', Icons.business),
        _buildSquareButton('Modelos', Icons.analytics),
        _buildSquareButton('Reportes', Icons.report),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: OutlinedButton(
        onPressed: () {
          // Aquí implementas la lógica para cerrar sesión
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen()), // Asegúrate de que esta ruta sea correcta
            (Route<dynamic> route) => false,
          );
        },
        child: Text('Cerrar Sesión'),
      ),
    );
  }

  void _onButtonPressed(String title, BuildContext context) {
    if (title == 'Establecimientos') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EstablishmentsPage()),
      );
    } else if (title == 'Modelos') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ModelsPage()),
      );
    }
    // Implementa casos similares para otros botones si es necesario
  }

  Widget _buildSquareButton(String title, IconData icon) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      onPressed: () => _onButtonPressed(title, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white),
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
