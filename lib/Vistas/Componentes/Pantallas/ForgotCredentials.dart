import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForgotCredentialsScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendRecoveryRequest(BuildContext context) async {
    // Lógica para enviar la solicitud a Firestore
    await FirebaseFirestore.instance.collection('solicitud_recuperacion').add({
      'email': _emailController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Muestra el diálogo de éxito
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Solicitud Enviada'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Tu solicitud de recuperación de credenciales ha sido enviada.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centrar el título

        title: Text(
          'Recuperación de Credenciales',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                _sendRecoveryRequest(context);
              },
              child: Text('Enviar Solicitud'),
            ),
          ],
        ),
      ),
    );
  }
}
