// import 'package:flutter/material.dart';
// import 'package:frontend/Componentes/BottomBar.dart';
// import 'package:frontend/Componentes/BuildGrid.dart';
// import 'package:frontend/Componentes/CreateNewButton.dart';
// import 'package:frontend/Componentes/TitleBar.dart';

// class ContentScreen extends StatefulWidget {
//   final String title;
//   final List<String> institutions;

//   ContentScreen({required this.title, required this.institutions});

//   @override
//   _ContentScreenState createState() => _ContentScreenState();
// }

// class _ContentScreenState extends State<ContentScreen> {
//   int currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     final int pageSize = 8;
//     final int totalPages = (widget.institutions.length / pageSize).ceil();
//     final List<String> currentPageItems = getCurrentPageItems(pageSize);

//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//         boxShadow: standardBoxShadow(),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TitleBarWidget(title: widget.title),
//           SizedBox(height: 16.0),
//           Divider(),
//           buildCreateNewButton(),
//           SizedBox(height: 8.0),
//           buildGrid(currentPageItems),
//           Divider(),
//           buildBottomNavigation(
//               totalPages: totalPages,
//               currentPage: currentPage,
//               onPageChanged: (newPage) {
//                 setState(() => currentPage = newPage);
//               }),
//         ],
//       ),
//     );
//   }

//   List<String> getCurrentPageItems(int pageSize) {
//     return widget.institutions
//         .skip(currentPage * pageSize)
//         .take(pageSize)
//         .toList();
//   }

//   List<BoxShadow> standardBoxShadow() {
//     return [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5),
//         spreadRadius: 5,
//         blurRadius: 7,
//         offset: Offset(0, 3),
//       ),
//     ];
//   }
// }
