import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Componentes/Grid/CardItem.dart';
import 'package:frontend/Componentes/Grid/Card_Details.dart';
import 'package:frontend/Componentes/Pantallas/FutureContent.dart';
import 'package:frontend/Componentes/Pantallas/RegContent.dart';
import 'package:frontend/Componentes/Sidebar/Institutions.dart';
import 'package:frontend/LoginPage.dart';
import 'package:frontend/NavPages/EstablismentReg.dart';
import 'package:frontend/NavPages/ReportMakerForm.dart';
import 'package:frontend/Wiki/InstitutionsWiki.dart';
import 'package:frontend/Wiki/ModelsWiki.dart';
import 'package:frontend/Wiki/ReportsWiki.dart';
import 'sidebar_profile.dart';

class CustomDrawer extends StatelessWidget {
  final Function(Widget) onSelectContent;

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
                onTap: () async {
                  List<CardItem> institutions =
                      await getInstitutionsFromFirestore(context);
                  onSelectContent(RegContent(
                    institutions: institutions,
                    title: 'Establecimientos',
                    isEstablishmentPage: true,
                    onHelpPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InstitutionsWiki()),
                      );
                    },
                    onCreateNewPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EstablishmentRegistrationForm()),
                      );
                    },
                    key: const ValueKey('establecimientos'),
                  ));
                },
              ),

              // ),
              // ListTile(
              //   title: const Text('Modelos Predictivos'),
              //   onTap: () {
              //     onSelectContent(
              //       RegContent(
              //         title: 'Modelos Predictivos',
              //         onHelpPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => ModelsWiki()),
              //           );
              //         },
              //         institutions: institutions2,
              //         key: const ValueKey('regContent'),
              //       ),
              //     );
              //   },
              // ),
              // // ... otros ListTiles para diferentes contenidos ...
              // ListTile(
              //   title: const Text('Reportes'),
              //   onTap: () {
              //     onSelectContent(
              //       RegContent(
              //         onHelpPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => ReportsWiki()),
              //           );
              //         },
              //         isEstablishmentPage: true,
              //         onCreateNewPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => ReportMakerForm()),
              //           );
              //         },
              //         title: 'Reportes',
              //         institutions: institutions2,
              //         key: const ValueKey('reportes'),
              //       ),
              //     );
              //   },
              // ),
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

  Future<List<CardItem>> getInstitutionsFromFirestore(
      BuildContext context) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('establecimientos').get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Establishment establishment = Establishment.fromMap(data);
        return CardItem(
          title: data['title'],
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    EstablishmentDetailsPage(establishment: establishment),
              ),
            );
          },
          imageUrl: data['imageUrl'],
          creationDate: data['creationDate'],
          author: data['author'],
          description: data['description'],
        );
      }).toList();
    } catch (e) {
      // Manejar el error
      print(e);
      return [];
    }
  }
}
