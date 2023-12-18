import 'package:flutter/material.dart';

class NavigationArrows extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const NavigationArrows(
      {super.key, required this.currentPage,
      required this.totalPages,
      required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (currentPage > 0) onPageChanged(currentPage - 1);
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (currentPage < totalPages - 1) onPageChanged(currentPage + 1);
          },
        ),
      ],
    );
  }
}
