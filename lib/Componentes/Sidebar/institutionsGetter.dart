import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/Componentes/Sidebar/Establishment.dart';

Future<List<Establishment>> getInstitutions() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('instituciones').get();
  return querySnapshot.docs
      .map((doc) => Establishment.fromFirestore(doc))
      .toList();
}
