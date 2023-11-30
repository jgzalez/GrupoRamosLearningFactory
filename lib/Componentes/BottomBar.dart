import 'package:flutter/material.dart';
import 'package:frontend/Componentes/NavigationArrows.dart';

Row BottomBar({
  required int totalPages,
  required int currentPage,
  required Function(int) onPageChanged,
}) {
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
