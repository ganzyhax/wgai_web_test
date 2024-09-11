import 'package:flutter/material.dart';

class GrantsContainer extends StatelessWidget {
  final String title;
  final String year;
  const GrantsContainer({
    super.key,
    required this.title,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(),
    );
  }
}
