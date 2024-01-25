import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Modelos/Reports.dart';
import 'package:frontend/Vistas/Componentes/Grid/CardItem.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/RegContent.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/ReportDetailsPage.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/ReportsRegistrationForm.dart';
import 'package:frontend/Vistas/Wiki/ReportsWiki.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  void _performSearch() {
    setState(() {
      searchQuery = searchController.text.toLowerCase();
    });
  }

  Stream<List<Report>> getReportsStream() {
    return FirebaseFirestore.instance.collection('reportes').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Report.fromFirestore(doc))
            .where((report) => report.title.toLowerCase().contains(searchQuery))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centrar el título
        title: Text(
          'Reportes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<List<Report>>(
        stream: getReportsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("No hay Reportes disponibles");
          }
          var reports = snapshot.data!;
          return RegContent(
            searchController: searchController, // Agrega esta línea

            title: 'Reportes',
            onSearch: _performSearch, // Pasamos la función de búsqueda aquí
            isEstablishmentPage: true,
            onHelpPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportsWiki()),
              );
            },
            onCreateNewPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportsRegistrationForm()),
              );
            },
            key: const ValueKey('establecimientos'),
            institutions: reports
                .map((report) => CardItem(
                      title: report.title,
                      imageUrl: report.imageUrl.isNotEmpty
                          ? report.imageUrl
                          : 'https://images.unsplash.com/photo-1530982011887-3cc11cc85693?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      creationDate: report.creationDate,
                      location: report.location,
                      description: report.description,
                      onDelete: () => onDelete(context, report),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ReportDetailsPage(report: report),
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

  void onEdit(BuildContext context, Report report) {
    // Navega a una pantalla de edición con los datos del establecimiento
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReportsRegistrationForm(
          reportToEdit: report,
        ),
      ),
    );
  }

  void onDelete(BuildContext context, Report report) {
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
                deleteEstablishmentFromFirestore(report.id);
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
    FirebaseFirestore.instance.collection('reportes').doc(id).delete();
    // Considera implementar alguna lógica para refrescar la lista de establecimientos
  }
}
