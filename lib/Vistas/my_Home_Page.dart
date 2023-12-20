import 'package:flutter/material.dart';
import 'package:frontend/Controladores/authService.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/EstablishmentPage.dart';

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

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 50.0,
          ),
          SizedBox(height: 10),
          Text(name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(role, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Divider(),
          _buildButtonBar(),
        ],
      ),
    );
  }

  Widget _buildButtonBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSquareButton('Establecimientos', Icons.business),
        _buildSquareButton('Modelos', Icons.analytics),
        _buildSquareButton('Reportes', Icons.report),
      ],
    );
  }

  void _onButtonPressed(String title, BuildContext context) {
    if (title == 'Establecimientos') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EstablishmentsPage()),
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
