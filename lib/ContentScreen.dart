import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  final String title;
  final List<String> institutions; // Lista de nombres de instituciones

  ContentScreen({required this.title, required this.institutions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 01), // Espacio entre Titulos y barra de búsqueda
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Acción para el botón de búsqueda
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10), // Añade un poco de espacio interno
              decoration: BoxDecoration(
                color: Colors.grey[200], // Color de fondo del cuadrado
                borderRadius: BorderRadius.circular(
                    15), // Bordes redondeados del cuadrado
                // Opcional: Añade una sombra
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: institutions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(
                      child: Text(institutions[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
