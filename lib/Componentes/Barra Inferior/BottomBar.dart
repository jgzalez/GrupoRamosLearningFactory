import 'package:flutter/material.dart';
// import 'package:frontend/Componentes/Barra%20Inferior/NavigationArrows.dart';

Row BottomBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: const Icon(Icons.help_outline),
        onPressed: () {},
      ),
      // NavigationArrows(
      //   currentPage: currentPage,
      //   totalPages: totalPages,
      //   onPageChanged: onPageChanged,
      // ),
    ],
  );
}
