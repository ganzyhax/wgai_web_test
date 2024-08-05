import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final bool? isDisabled;
  final String text;
  final Function()? onTap;
  final double? height;
  const CustomButton(
      {super.key,
      this.isDisabled,
      required this.text,
      this.onTap,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: (isDisabled == true)
                ? AppColors.primaryDisabled
                : AppColors.primary),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
