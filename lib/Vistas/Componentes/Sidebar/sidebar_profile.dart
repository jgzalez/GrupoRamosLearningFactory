import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imageUrl; // URL de la imagen del perfil
  final String name; // Nombre del usuario
  final String role; // Rol o posición

  const ProfileWidget({
    super.key,
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
          radius: 25, // Tamaño del avatar
          backgroundImage: NetworkImage(imageUrl), // Imagen del perfil
        ),
        const SizedBox(height: 8), // Espacio entre imagen y texto
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          role,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}
