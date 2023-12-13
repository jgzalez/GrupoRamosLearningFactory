import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/Componentes/Sidebar/Institutions.dart';

Future<List<Establishment>> getInstitutions() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('instituciones').get();
  return querySnapshot.docs
      .map((doc) => Establishment.fromMap(doc.data() as Map<String, dynamic>))
      .toList();
}
