import 'package:flutter/material.dart';

class SpashButton extends StatelessWidget {
  final String title;
  final String asset;
  final bool? isSelected;
  final Function() onTap;
  const SpashButton(
      {super.key,
      required this.title,
      required this.asset,
      this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: (isSelected == true)
                ? Color.fromARGB(255, 175, 204, 254)
                : Color.fromARGB(255, 236, 236, 241)),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(width: 45, child: Image.asset(asset)),
            SizedBox(
              width: 25,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
