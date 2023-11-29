import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  final String title;
  final List<String> institutions; // Lista de nombres de instituciones

  ContentScreen({required this.title, required this.institutions});

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    int pageSize = 8;
    int totalPages = (widget.institutions.length / pageSize).ceil();

    // Divide los datos en páginas
    List<String> currentPageItems = widget.institutions
        .skip(currentPage * pageSize)
        .take(pageSize)
        .toList();

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10), // Espacio entre Titulos y barra de búsqueda
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
          Divider(), // Separador

          // Botón para "Crear nuevo"
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Crear nuevo"),
              onPressed: () {
                // Acción para el botón de crear nuevo
              },
            ),
          ),
          SizedBox(height: 8.0),

          // Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: currentPageItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Center(
                    child: Text(currentPageItems[index]),
                  ),
                );
              },
              physics:
                  NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento
            ),
          ),
          Divider(), // Otro Separador

          // Botones Inferiores
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Esto separa los widgets en los extremos
            children: [
              // Botón de ayuda (?)
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  // Acción para el botón de ayuda
                },
              ),
              // Contenedor para alinear las flechas a la derecha
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Esto hace que la fila ocupe el mínimo espacio necesario
                  children: [
                    // Botón de navegación para regresar
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          currentPage = (currentPage > 0) ? currentPage - 1 : 0;
                        });
                      },
                    ),
                    // Botón de navegación para avanzar
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        setState(() {
                          currentPage = (currentPage < totalPages - 1)
                              ? currentPage + 1
                              : totalPages - 1;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
