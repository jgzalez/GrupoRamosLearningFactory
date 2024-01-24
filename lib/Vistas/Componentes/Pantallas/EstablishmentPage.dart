import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Controladores/EstablismentReg.dart';
import 'package:frontend/Modelos/Establishment.dart';
import 'package:frontend/Vistas/Componentes/Grid/CardItem.dart';
import 'package:frontend/Vistas/Componentes/Grid/Establishment_Details.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/RegContent.dart';
import 'package:frontend/Vistas/Wiki/InstitutionsWiki.dart';

class EstablishmentsPage extends StatefulWidget {
  @override
  _EstablishmentsPageState createState() => _EstablishmentsPageState();
}

class _EstablishmentsPageState extends State<EstablishmentsPage> {
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

  void dispose() {
    searchController.dispose(); // No olvides liberar el controlador
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      searchQuery = searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Establecimientos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<List<Establishment>>(
        stream: getInstitutionsStream(),
        builder: (context, snapshot) {
          print(context);
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("No hay establecimientos disponibles");
          }
          var establishments = snapshot.data!;
          return RegContent(
            title: 'Establecimientos',
            onSearch: _performSearch, // Cambia esto para usar el nuevo método
            isEstablishmentPage: true,
            searchController: searchController, // Agrega esta línea

            onHelpPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InstitutionsWiki()),
              );
            },
            onCreateNewPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EstablishmentRegistrationForm()),
              );
            },
            key: const ValueKey('establecimientos'),
            institutions: establishments
                .map((establishment) => CardItem(
                      title: establishment.title,
                      location: establishment.location,
                      creationDate: establishment.creationDate,
                      imageUrl: establishment.imageUrl,
                      description: establishment.description,
                      onEdit: () => onEdit(context, establishment),
                      onDelete: () => onDelete(context, establishment),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EstablishmentDetailsPage(
                                establishment: establishment),
                          ),
                        );
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
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
          content: Text(
              '¿Estás seguro de que deseas eliminar este establecimiento?'),
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

  Stream<List<Establishment>> getInstitutionsStream() {
    return FirebaseFirestore.instance
        .collection('establecimientos')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Establishment.fromFirestore(doc))
            .where((establishment) =>
                establishment.title.toLowerCase().contains(searchQuery))
            .toList());
  }
}
