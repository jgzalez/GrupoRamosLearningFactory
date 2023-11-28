import 'package:flutter/material.dart';

import 'ContentScreen.dart';

class ContentWidgetOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ContentScreen(
      title: 'Instituciones',
      institutions: [
        'Institución 1',
        'Institución 2',
        'Institución 3'
      ], // Reemplaza con tus datos
    ));
  }
}

class ContentWidgetTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ContentScreen(
      title: 'Modelos',
      institutions: [
        'Modelo 1',
        'Modelo 2',
        'Modelo 3'
      ], // Reemplaza con tus datos
    ));
  }
}

class ContentWidgetThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ContentScreen(
      title: 'Reportes',
      institutions: [
        'Reporte 1',
        'Reporte 2',
        'Reporte 3'
      ], // Reemplaza con tus datos
    ));
  }
}
