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
                  'Esta sección del aplicativo está destinada a la administración y creación de los diferentes establecimientos a ser procesados y utilizados por el aplicativo \n \n'
                  'Los establecimientos del Grupo Ramos en la aplicación se dividen en dos categorías: \n \n'
                  'Sirena Market e Híper Market. \n\n'
                  'Cada categoría tiene modelos predictivos asignados para evaluar y analizar su rendimiento.'
                  '\nLos mismos estarán representados en la intefaz de establecimientos como tarjetas con algunas informaciones relevantes\n\n'
                  'Para registrar un nuevo establecimiento, el usuario debe presionar el botón superior del modal  "Crear Nuevo"\n'),

              // Estructura de Datos y Modelos
              sectionTitle('Estructura de Datos y Modelos'),
              sectionContent(
                  'Al registrar un determinado establecimiento, los usuarios del aplicativo deben introducir información detallada sobre el mismo.\n'),
              sectionSubtitle('Modelo de Entidad:'),
              sectionContent(
                  'El modelo de establecimiento cuenta de los siguientes atributos: \n\n'
                  '1- Nombre del Establecimiento\n'
                  '2- Ubicación Geográfica\n'
                  '3- Número de Empleados\n'
                  '4- Horarios de Atención\n'
                  '5- Tamaño del Establecimiento\n'
                  '6- Flujo de Clientes\n'
                  '7- Tipo de Establecimiento\n'
                  '8- Aforo Máximo\n'
                  '9- Año de Fundación\n'
                  '10- Valoraciones de Clientes (Archivo)\n'
                  '11- Número de Reseñas (Archivo)\n'
                  '12- Historial de Ventas (Archivo)\n'
                  '13- Datos Demográficos de Clientes (Archivo)\n'
                  '14- Ingresos Anuales (Archivo)\n'
                  '15- Gastos Operativos (Archivo)\n'
                  '16- Eventos Especiales (Archivo)\n'
                  '17- Inventario de Productos/Servicios (Archivo)\n'
                  '18- Impacto de Factores Estacionales (Archivo)\n'
                  '19- Competencia Local (Archivo)\n'
                  '20- Tendencias de Mercado (Archivo)\n'),

              // Funcionalidades Clave
              sectionTitle('Funcionalidades Clave'),
              sectionContent(
                  'La sección de establecimientos de la aplicación permite a los usuarios crear, leer, actualizar y eliminar información sobre los establecimientos '
                  'mediante una interfaz intuitiva, facilitando la gestión de los datos.'),

              // Interfaz de Usuario
              sectionSubtitle('Interfaz de Usuario'),
              sectionContent(
                  'La aplicación incluye tarjetas y páginas detalladas para cada establecimiento, permitiendo a los usuarios '
                  'acceder a información completa y realizar acciones específicas relacionadas con cada establecimiento.'),

              // Integraciones y Servicios Externos
              sectionSubtitle('Integraciones y Servicios Externos'),
              sectionContent(
                  'La aplicación utiliza servicios de mapas y geolocalización para manejar la ubicación exacta de los establecimientos, '
                  'mejorando la experiencia del usuario y proporcionando datos precisos para el análisis.'),

              // Seguridad y Privacidad
              sectionSubtitle('Seguridad y Privacidad'),
              sectionContent(
                  'Se implementan medidas rigurosas para proteger los datos sensibles de los establecimientos. Los accesos y permisos '
                  'se gestionan cuidadosamente para asegurar que solo los usuarios autorizados puedan ver o editar la información.'),

              // Casos de Uso y Ejemplos
              sectionSubtitle('Casos de Uso y Ejemplos'),
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

// Método para Subtítulos
Widget sectionSubtitle(String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      subtitle,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
    ),
  );
}
