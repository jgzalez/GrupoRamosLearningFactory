// import 'package:flutter/material.dart';
// import 'package:frontend/Componentes/Grid/CardItem.dart';
// import 'package:frontend/Componentes/Sidebar/Institutions.dart';
// import 'package:frontend/Componentes/Sidebar/institutionsGetter.dart';

// Widget buildEstablishments(BuildContext context) {
//   return FutureBuilder(
//     future: getInstitutions(),
//     builder:
//         (BuildContext context, AsyncSnapshot<List<Establishment>> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       } else {
//         return GridView.builder(
//           itemCount: snapshot.data!.length,
//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           itemBuilder: (BuildContext context, int index) {
//             return CardItem(
//               title: snapshot.data![index].title,
//               imageUrl: snapshot.data![index].imageUrl,
//               creationDate: snapshot.data![index].creationDate,
//               author: snapshot.data![index].author,
//               description: snapshot.data![index].description,
//             );
//           },
//         );
//       }
//     },
//   );
// }
