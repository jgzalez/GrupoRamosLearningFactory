import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Componentes/Grid/CardItem.dart';
import 'package:frontend/Componentes/Pantallas/RegContent.dart';
import 'package:frontend/LoginPage.dart';
import 'package:frontend/NavPages/EstablismentReg.dart';
import 'package:frontend/NavPages/ReportMakerForm.dart';
import 'package:frontend/Wiki/InstitutionsWiki.dart';
import 'package:frontend/Wiki/ModelsWiki.dart';
import 'package:frontend/Wiki/ReportsWiki.dart';
import 'sidebar_profile.dart';

class CustomDrawer extends StatelessWidget {
  final Function(Widget) onSelectContent;

  // Crear listas de CardItems
  final List<CardItem> institutions1 = [
    CardItem(
        title: 'Institución 1',
        imageUrl:
            'https://cdn.pixabay.com/photo/2019/04/04/15/17/smartphone-4103051_640.jpg',
        creationDate: '12-04-2023',
        author: 'Jose Gonzalez',
        description: 'Esta es una carta de prueba'),
    CardItem(
        title: 'Institución 2',
        imageUrl:
            'https://cdn.com.do/wp-content/uploads/2022/05/mozart-la-para-6272e269a17a6.jpg',
        creationDate: '12-04-2023',
        author: 'Jose Gonzalez',
        description: 'Esta es una carta de prueba'),
    // ... añade más CardItems ...
  ];

  final List<CardItem> institutions2 = [
    CardItem(
        title: 'Modelo 1',
        imageUrl:
            'https://media.istockphoto.com/id/530685719/es/foto/grupo-de-empresarios-de-pie-en-el-pasillo-sonriendo-y-hablando-juntos.webp?b=1&s=612x612&w=0&k=20&c=ysTsFXorWFgsCfxq-Y1qwJtQLUxWavFQ24tVI8ZNabg=',
        creationDate: '12-04-2023',
        author: 'Jose Gonzalez',
        description: 'Esta es una carta de prueba'),
    CardItem(
        title: 'Modelo 2',
        imageUrl:
            'https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg',
        creationDate: '12-04-2023',
        author: 'Jose Gonzalez',
        description: 'Esta es una carta de prueba'),
    // ... añade más CardItems ...
  ];
  CustomDrawer({super.key, required this.onSelectContent});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 31, 122, 201),
                ),
                child: FutureBuilder<Map<String, dynamic>?>(
                  future: obtenerDatosUsuario(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        var userData = snapshot.data!;
                        String imageUrl = userData['profileImage'] ??
                            'url_imagen_por_defecto';
                        String name =
                            userData['name'] ?? 'Nombre no disponible';
                        String role = userData['role'] ?? 'Rol no disponible';

                        return DrawerHeader(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 31, 122, 201),
                          ),
                          child: ProfileWidget(
                            imageUrl: imageUrl,
                            name: name,
                            role: role,
                          ),
                        );
                      } else {
                        return DrawerHeader(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 31, 122, 201),
                          ),
                          child: Text("No se encontraron datos del usuario."),
                        );
                      }
                    }
                    return DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 31, 122, 201),
                      ),
                      child:
                          CircularProgressIndicator(), // Mientras los datos están cargando
                    );
                  },
                ),
              ),
              // ... tus ListTiles para Establecimientos, Modelos Predictivos, etc. ...
              ListTile(
                title: const Text('Establecimientos'),
                onTap: () {
                  onSelectContent(RegContent(
                    title: 'Establecimientos',
                    isEstablishmentPage: true,
                    onHelpPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstitutionsWiki()));
                    },
                    onCreateNewPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EstablishmentRegistrationForm()),
                      );
                    },
                    institutions: institutions1,
                    key: const ValueKey('establecimientos'),
                  ));
                },
              ),
              ListTile(
                title: const Text('Modelos Predictivos'),
                onTap: () {
                  onSelectContent(
                    RegContent(
                      title: 'Modelos Predictivos',
                      onHelpPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ModelsWiki()),
                        );
                      },
                      institutions: institutions2,
                      key: const ValueKey('regContent'),
                    ),
                  );
                },
              ),
              // ... otros ListTiles para diferentes contenidos ...
              ListTile(
                title: const Text('Reportes'),
                onTap: () {
                  onSelectContent(
                    RegContent(
                      onHelpPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportsWiki()),
                        );
                      },
                      isEstablishmentPage: true,
                      onCreateNewPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportMakerForm()),
                        );
                      },
                      title: 'Reportes',
                      institutions: institutions2,
                      key: const ValueKey('reportes'),
                    ),
                  );
                },
              ),
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(Icons.exit_to_app), // Icono de puerta/salida
              title: const Text('Cerrar Sesión'),
              onTap: () => _logout(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> obtenerDatosUsuario() async {
    User? usuario = FirebaseAuth.instance.currentUser;
    if (usuario != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(usuario.uid)
          .get();
      return snapshot.data() as Map<String, dynamic>?;
    }
    return null;
  }
}
