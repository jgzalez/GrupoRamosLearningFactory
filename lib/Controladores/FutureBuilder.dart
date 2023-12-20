import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Vistas/Componentes/Sidebar/sidebar_profile.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: obtenerDatosUsuario(),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var userData = snapshot.data!;
            String imageUrl =
                userData['profileImage'] ?? 'url_imagen_por_defecto';
            String name = userData['name'] ?? 'Nombre no disponible';
            String role = userData['role'] ?? 'Rol no disponible';

            return ProfileWidget(
              imageUrl: imageUrl,
              name: name,
              role: role,
            );
          } else {
            return Text("No se encontraron datos del usuario.");
          }
        }
        return CircularProgressIndicator(); // Mientras los datos están cargando
      },
    );
  }

  Future<Map<String, dynamic>?> obtenerDatosUsuario() async {
    User? usuario = FirebaseAuth.instance.currentUser;
    if (usuario != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(usuario.uid)
          .get();
      return snapshot.data() as Map<String, dynamic>?;
    }
    return null;
  }
}
