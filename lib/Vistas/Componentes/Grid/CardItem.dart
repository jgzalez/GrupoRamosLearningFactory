import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String creationDate;
  final String author;
  final String description;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  CardItem({
    required this.onTap,
    required this.imageUrl,
    required this.title,
    required this.creationDate,
    required this.author,
    required this.description,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String effectiveImageUrl =
        imageUrl.isNotEmpty ? imageUrl : 'url_de_la_imagen_predeterminada';
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
                  height:
                      screenWidth * 0.1, // Height proportional to screen width
                  width: double.infinity,
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: PopupMenuButton<String>(
                    onSelected: (String result) {
                      if (result == 'edit') {
                        onEdit();
                      } else if (result == 'delete') {
                        onDelete();
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Editar'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Borrar'),
                      ),
                    ],
                  ),
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
                  Text(
                    '$creationDate - $author',
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
          ],
        ),
      ),
    );
  }
}
