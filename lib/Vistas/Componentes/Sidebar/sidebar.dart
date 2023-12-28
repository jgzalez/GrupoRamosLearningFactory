import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Vistas/Componentes/Grid/CardItem.dart';
import 'package:frontend/Vistas/Componentes/Grid/Establishment_Details.dart';
import 'package:frontend/Modelos/Establishment.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/LoginPage.dart';
import 'package:frontend/Controladores/EstablismentReg.dart';
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
              // ListTile(
              //   title: const Text('Establecimientos'),
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => Scaffold(
              //           appBar: AppBar(
              //             title: Text('Establecimientos'),
              //           ),
              //           body: StreamBuilder<List<Establishment>>(
              //             stream: getInstitutionsStream(), // Cambio a stream
              //             builder: (context, snapshot) {
              //               if (snapshot.connectionState ==
              //                   ConnectionState.waiting) {
              //                 return CircularProgressIndicator();
              //               }
              //               if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //                 return Text(
              //                     "No hay establecimientos disponibles");
              //               }
              //               var establishments = snapshot.data!;
              //               return RegContent(
              //                 title: 'Establecimientos',
              //                 isEstablishmentPage: true,
              //                 onHelpPressed: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) => InstitutionsWiki()),
              //                   );
              //                 },
              //                 onCreateNewPressed: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             EstablishmentRegistrationForm()),
              //                   );
              //                 },
              //                 key: const ValueKey('establecimientos'),
              //                 institutions: establishments
              //                     .map((establishment) => CardItem(
              //                           title: establishment.title,
              //                           imageUrl:
              //                               establishment.imageUrl.isNotEmpty
              //                                   ? establishment.imageUrl
              //                                   : 'url_imagen_genérica',
              //                           creationDate:
              //                               establishment.creationDate,
              //                           author: establishment.author,
              //                           description: establishment.description,
              //                           onEdit: () =>
              //                               onEdit(context, establishment),
              //                           onDelete: () =>
              //                               onDelete(context, establishment),
              //                           onTap: () {
              //                             Navigator.of(context).push(
              //                               MaterialPageRoute(
              //                                 builder: (context) =>
              //                                     EstablishmentDetailsPage(
              //                                         establishment:
              //                                             establishment),
              //                               ),
              //                             );
              //                           },
              //                         ))
              //                     .toList(),
              //               );
              //             },
              //           ),
              //         ),
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
        Establishment establishment = Establishment.fromFirestore(doc);
        return CardItem(
          title: data['title'],
          onEdit: () => onEdit(context, establishment),
          onDelete: () => onDelete(context, establishment),
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

void onEdit(BuildContext context, Establishment establishment) {
  // Navega a una pantalla de edición con los datos del establecimiento
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EstablishmentRegistrationForm(
        establishmentToEdit: establishment,
      ),
    ),
  );
}

void onDelete(BuildContext context, Establishment establishment) {
  // Muestra un diálogo de confirmación antes de proceder con la eliminación
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmar eliminación'),
        content:
            Text('¿Estás seguro de que deseas eliminar este establecimiento?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
          ),
          TextButton(
            child: Text('Eliminar'),
            onPressed: () {
              // Elimina el establecimiento de Firestore
              deleteEstablishmentFromFirestore(establishment.id);
              Navigator.of(context).pop(); // Cierra el diálogo
            },
          ),
        ],
      );
    },
  );
}

void deleteEstablishmentFromFirestore(String id) {
  // Lógica para eliminar el establecimiento de Firestore
  FirebaseFirestore.instance.collection('establecimientos').doc(id).delete();
  // Considera implementar alguna lógica para refrescar la lista de establecimientos
}
