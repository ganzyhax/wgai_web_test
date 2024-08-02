import 'package:flutter/material.dart';

class SpashButton extends StatelessWidget {
  final String title;
  final String asset;
  const SpashButton({super.key, required this.title, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(0, 236, 236, 241)),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          SizedBox(width: 45, child: Image.asset(asset)),
          SizedBox(
            width: 25,
          ),
          Text(title),
        ],
      ),
    );
  }
}
