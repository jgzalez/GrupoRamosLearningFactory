import 'package:flutter/material.dart';
import 'package:frontend/Vistas/Componentes/Barra%20Inferior/BottomBar.dart';
import 'package:frontend/Vistas/Componentes/Grid/BuildGrid.dart';
import 'package:frontend/Vistas/Componentes/Barra%20Superior/CreateNewButton.dart';
import 'package:frontend/Vistas/Componentes/Barra%20Superior/TitleBar.dart';

class RegContent extends StatelessWidget {
  final String title;
  final List<Widget> institutions;
  final VoidCallback? onCreateNewPressed;
  final bool isEstablishmentPage; // Variable final
  final VoidCallback? onHelpPressed;
  final VoidCallback onSearch;
  final TextEditingController searchController;

  // final Function(String) onSearch; // Nuevo parámetro para la búsqueda

  const RegContent({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.title,
    required this.institutions,
    this.onCreateNewPressed,
    this.isEstablishmentPage = false,
    this.onHelpPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: standardBoxShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleBarWidget(
            title: title, onSearch: onSearch,
            controller: searchController, // Pasa el controlador aquí
          ),
          const SizedBox(height: 16.0),
          const Divider(),
          isEstablishmentPage
              ? CreateNewButton(onPressed: onCreateNewPressed)
              : Container(),
          const SizedBox(height: 8.0),
          Expanded(child: GridBuilderWidget(items: institutions)),
          BottomBar(
            onHelpPressed: onHelpPressed,
          )
        ],
      ),
    );
  }

  List<BoxShadow> standardBoxShadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 1,
        offset: const Offset(0, 3),
      ),
    ];
  }
}
