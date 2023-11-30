import 'package:flutter/material.dart';
import 'package:frontend/Componentes/BottomBar.dart';
import 'package:frontend/Componentes/BuildGrid.dart';
import 'package:frontend/Componentes/CreateNewButton.dart';
import 'package:frontend/Componentes/TitleBar.dart';

class RegContent extends StatelessWidget {
  final String title;
  final List<String> institutions;

  const RegContent({
    Key? key,
    required this.title,
    required this.institutions,
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
          TitleBarWidget(title: title),
          const SizedBox(height: 16.0),
          const Divider(),
          CreateNewButton(),
          const SizedBox(height: 8.0),
          Expanded(child: GridBuilderWidget(items: institutions)),
        ],
      ),
    );
  }

  List<BoxShadow> standardBoxShadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ];
  }
}
