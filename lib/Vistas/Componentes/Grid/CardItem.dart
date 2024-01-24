import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String? creationDate;
  final String description;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  CardItem({
    required this.onTap,
    required this.imageUrl,
    required this.title,
    required this.location,
    this.creationDate,
    required this.description,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // URL de la imagen por defecto
    String defaultImageUrl =
        'https://comprarmaquinariahosteleria.com/blog/wp-content/uploads/2023/02/como-montar-tienda-alimentacion.jpg';

    // Usar imageUrl si no es nulo y no está vacío, de lo contrario usar la imagen por defecto
    String effectiveImageUrl = (imageUrl != null && imageUrl!.isNotEmpty)
        ? imageUrl!
        : defaultImageUrl;
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                Image.network(
                  effectiveImageUrl,
                  fit: BoxFit.cover,
                  height: screenWidth * 0.09,
                  width: double.infinity,
                ),
                if (onEdit != null || onDelete != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: buildPopupMenu(),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.025,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  if (creationDate != null)
                    Text(
                      '$creationDate',
                      style: TextStyle(
                        fontSize: screenWidth * 0.01,
                        color: Colors.grey[600],
                      ),
                    ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: screenWidth * 0.01),
                  ),
                ],
              ),
            ),
            // Aquí puedes añadir tus botones de editar y eliminar si los necesitas
          ],
        ),
      ),
    );
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result == 'edit' && onEdit != null) {
          onEdit!();
        } else if (result == 'delete' && onDelete != null) {
          onDelete!();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        if (onEdit != null)
          const PopupMenuItem<String>(
            value: 'edit',
            child: Text('Editar'),
          ),
        if (onDelete != null)
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Borrar'),
          ),
      ],
      icon:
          Icon(Icons.more_vert, color: Colors.white), // Icono del botón en gris
    );
  }
}
