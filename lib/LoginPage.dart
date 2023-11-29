import 'package:flutter/material.dart';
import 'main.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Sistema de Optimización y Análisis de Recursos Humanos (SOARH)'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                SizedBox(width: 30.0),
                // Formulario de inicio de sesión
                Container(
                  width: 300,
                  // Permite que el formulario se ajuste al tamaño de la pantalla
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Campo de texto para el ID de empleado
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'ID Empleado',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20.0),
                      // Campo de texto para la contraseña
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      // Botón de Iniciar Sesión
                      ElevatedButton(
                        child: Text('Iniciar Sesión'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        },
                      ),
                      SizedBox(height: 20.0),
                      // Botón de Olvidaste tus credenciales
                      TextButton(
                        child: Text('Olvidaste tus credenciales?'),
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
