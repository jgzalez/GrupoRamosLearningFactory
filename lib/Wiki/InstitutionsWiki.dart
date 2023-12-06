import 'package:flutter/material.dart';

class InstitutionsWiki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Establecimientos Grupo Ramos Wiki'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Descripción General
              sectionTitle('Descripción General'),
              sectionContent(
                  'Los establecimientos del Grupo Ramos en la aplicación se dividen en dos categorías: '
                  'Sirena Market e Híper Market. Cada categoría tiene modelos predictivos asignados para evaluar y analizar su rendimiento.'),

              // Estructura de Datos y Modelos
              sectionTitle('Estructura de Datos y Modelos'),
              sectionContent(
                  'Los usuarios deben introducir información detallada sobre cada establecimiento, incluyendo nombre, ubicación, '
                  'tipo, horarios de atención, entre otros. Estos datos son fundamentales para el análisis predictivo en la aplicación.'),

              // Funcionalidades Clave
              sectionTitle('Funcionalidades Clave'),
              sectionContent(
                  'La aplicación permite a los usuarios crear, leer, actualizar y eliminar información sobre los establecimientos '
                  'mediante una interfaz intuitiva, facilitando la gestión de los datos.'),

              // Interfaz de Usuario
              sectionTitle('Interfaz de Usuario'),
              sectionContent(
                  'La aplicación incluye tarjetas y páginas detalladas para cada establecimiento, permitiendo a los usuarios '
                  'acceder a información completa y realizar acciones específicas relacionadas con cada establecimiento.'),

              // Integraciones y Servicios Externos
              sectionTitle('Integraciones y Servicios Externos'),
              sectionContent(
                  'La aplicación utiliza servicios de mapas y geolocalización para presentar la ubicación exacta de los establecimientos, '
                  'mejorando la experiencia del usuario y proporcionando datos precisos para el análisis.'),

              // Seguridad y Privacidad
              sectionTitle('Seguridad y Privacidad'),
              sectionContent(
                  'Se implementan medidas rigurosas para proteger los datos sensibles de los establecimientos. Los accesos y permisos '
                  'se gestionan cuidadosamente para asegurar que solo los usuarios autorizados puedan ver o editar la información.'),

              // Casos de Uso y Ejemplos
              sectionTitle('Casos de Uso y Ejemplos'),
              sectionContent(
                  'Los establecimientos del Grupo Ramos son utilizados en diversos escenarios dentro de la aplicación, '
                  'desde análisis de datos hasta interacciones específicas del usuario con cada establecimiento.'),

              // Actualizaciones y Mantenimiento
              sectionTitle('Actualizaciones y Mantenimiento'),
              sectionContent(
                  'La aplicación mantiene un registro de todas las actualizaciones importantes relacionadas con los establecimientos, '
                  'y se planifican mejoras continuas para enriquecer aún más las funcionalidades y la precisión del análisis.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget sectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16),
    );
  }
}
