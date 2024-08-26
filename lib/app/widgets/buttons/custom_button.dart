import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final bool? isDisabled;
  final String text;
  final Function() onTap;
  final double? height;
  final Color? bgColor;
  final Color? textColor;
  final bool? isLoading;
  final IconData? icon;
  final Color? iconColor;
  final double? borderRadius;
  const CustomButton(
      {super.key,
      this.isDisabled,
      this.icon,
      this.iconColor,
      this.bgColor,
      this.borderRadius,
      this.isLoading,
      this.textColor,
      required this.text,
      required this.onTap,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isDisabled != null)
          ? (isDisabled == true)
              ? null
              : onTap
          : onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: (borderRadius == null)
                ? BorderRadius.circular(7)
                : BorderRadius.circular(borderRadius!),
            color: (bgColor == null)
                ? (isDisabled == true)
                    ? AppColors.primaryDisabled
                    : AppColors.primary
                : (isDisabled != null)
                    ? (isDisabled == true)
                        ? Colors.grey[200]
                        : AppColors.whiteForText
                    : bgColor),
        child: Center(
          child: (isLoading == true)
              ? SizedBox(
                  width: 23,
                  height: 23,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
              : (icon != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: (iconColor == null) ? Colors.white : iconColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: (textColor == null)
                                  ? Colors.white
                                  : textColor),
                        ),
                      ],
                    )
                  : Container(
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                (textColor == null) ? Colors.white : textColor),
                      ),
                    ),
        ),
      ),
    );
  }
}
