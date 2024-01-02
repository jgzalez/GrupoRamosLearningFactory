import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Modelos/Models.dart';
import 'package:frontend/Vistas/Componentes/Grid/CardItem.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/ModelDetails.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/RegContent.dart';
import 'package:frontend/Vistas/Wiki/ModelsWiki.dart';

class ModelsPage extends StatefulWidget {
  @override
  _ModelsPageState createState() => _ModelsPageState();
}

class _ModelsPageState extends State<ModelsPage> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  void _performSearch() {
    setState(() {
      searchQuery = searchController.text.toLowerCase();
    });
  }

  Stream<List<Model>> getModelsStream() {
    return FirebaseFirestore.instance.collection('modelos').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Model.fromFirestore(doc))
            .where((model) => model.title.toLowerCase().contains(searchQuery))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modelos'),
      ),
      body: StreamBuilder<List<Model>>(
        stream: getModelsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("No hay modelos disponibles");
          }
          var models = snapshot.data!;
          return RegContent(
            searchController: searchController, // Agrega esta línea

            title: 'Modelos',
            onSearch: _performSearch,
            onHelpPressed: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((context) => ModelsWiki())))
            },
            institutions: models
                .map((model) => CardItem(
                      title: model.title,
                      imageUrl: model.imageUrl.isNotEmpty
                          ? model.imageUrl
                          : 'https://images.unsplash.com/photo-1581090700227-1e37b190418e?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      creationDate: model.creationDate,
                      author: model.author,
                      description: model.description,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ModelDetailsPage(model: model),
                          ),
                        );
                      },
                    ))
                .toList(),
            isEstablishmentPage: false,
          );
        },
      ),
    );
  }
}
