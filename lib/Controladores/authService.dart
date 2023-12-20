import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> obtenerDatosUsuario() async {
    User? usuario = _auth.currentUser;
    if (usuario != null) {
      try {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(usuario.uid).get();
        return snapshot.data() as Map<String, dynamic>?;
      } catch (e) {
        print('Error al obtener datos del usuario: $e');
        return null;
      }
    } else {
      print('No hay usuario autenticado');
      return null;
    }
  }
}
