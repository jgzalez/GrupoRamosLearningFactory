import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Controladores/EstablismentReg.dart';
import 'package:frontend/Modelos/Establishment.dart';
import 'package:frontend/Vistas/Componentes/Grid/CardItem.dart';
import 'package:frontend/Vistas/Componentes/Grid/Card_Details.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/RegContent.dart';
import 'package:frontend/Vistas/Wiki/InstitutionsWiki.dart';

class EstablishmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Establecimientos'),
      ),
      body: StreamBuilder<List<Establishment>>(
        stream: getInstitutionsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("No hay establecimientos disponibles");
          }
          var establishments = snapshot.data!;
          return RegContent(
            title: 'Establecimientos',
            isEstablishmentPage: true,
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
                      imageUrl: establishment.imageUrl.isNotEmpty
                          ? establishment.imageUrl
                          : 'url_imagen_genérica',
                      creationDate: establishment.creationDate,
                      author: establishment.author,
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
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Establishment.fromFirestore(doc);
      }).toList();
    });
  }
}
