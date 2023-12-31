import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/Vistas/Componentes/Pantallas/ForgotCredentials.dart';
import 'package:frontend/Vistas/my_Home_Page.dart';

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

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de Inicio de Sesión'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('No se pudo iniciar sesión.'),
                  Text('Detalle del error: $e'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sistema de Optimización y Análisis de Recursos Humanos (SOARH)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ForgotCredentialsScreen()),
                          );
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
