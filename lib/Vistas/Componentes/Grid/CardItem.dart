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
    String effectiveImageUrl = imageUrl.isNotEmpty
        ? imageUrl
        : 'https://thefoodtech.com/wp-content/uploads/2020/05/Mi-tienda-segura-828x548.jpg';
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ... resto del código ...
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
          ],
        ),
      ),
    );
  }
}
