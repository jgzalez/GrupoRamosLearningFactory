import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/Vistas/my_Home_Page.dart';

import '../../../main.dart';

class LoginScreen extends StatelessWidget {
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Asignar una imagen de perfil por defecto o buscar una existente
        String defaultImageUrl =
            'https://st3.depositphotos.com/12985790/19065/i/1600/depositphotos_190657278-stock-photo-smiling.jpg';

        // Crear o actualizar el perfil del usuario en Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'profileImage': defaultImageUrl,
          // otros campos que desees añadir
        }, SetOptions(merge: true));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Sistema de Optimización y Análisis de Recursos Humanos (SOARH)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Imagen de la empresa
                Image.network(
                  'https://static.wikia.nocookie.net/logopedia/images/8/8e/Grupo_Ramos_2014_logo.png', // Reemplaza con el enlace de tu logo
                  width: 150, // Ajusta el ancho según tus necesidades
                ),
                const SizedBox(width: 30.0),
                // Formulario de inicio de sesión
                SizedBox(
                  width: 300,
                  // Permite que el formulario se ajuste al tamaño de la pantalla
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Campo de texto para el ID de empleado
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20.0),
                      // Campo de texto para la contraseña
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0),
                      // Botón de Iniciar Sesión
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () => _login(context),
                        child: const Text('Iniciar Sesión'),
                      ),
                      const SizedBox(height: 20.0),
                      // Botón de Olvidaste tus credenciales
                      TextButton(
                        child: const Text('Olvidaste tus credenciales?'),
                        onPressed: () {
                          // Acción para olvidar credenciales
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
