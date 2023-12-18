import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Componentes/Sidebar/Establishment.dart';
import 'package:frontend/NavPages/EstablismentReg.dart';

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
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
                Positioned(
                  right: 0,
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
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    '$creationDate - $author',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
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
