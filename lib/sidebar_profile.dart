import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imageUrl; // URL de la imagen del perfil
  final String name; // Nombre del usuario
  final String role; // Rol o posición

  ProfileWidget({
    required this.imageUrl,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40, // Tamaño del avatar
          backgroundImage: NetworkImage(imageUrl), // Imagen del perfil
        ),
        SizedBox(height: 8), // Espacio entre imagen y texto
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          role,
          style: TextStyle(
            fontSize: 14,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}
