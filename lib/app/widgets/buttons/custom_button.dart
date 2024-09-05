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
  final bool? iconOnRight;
  final FontWeight? textWeight;
  final double? textSize;
  const CustomButton(
      {super.key,
      this.isDisabled,
      this.icon,
      this.iconColor,
      this.bgColor,
      this.borderRadius,
      this.textWeight,
      this.iconOnRight,
      this.textSize,
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
                      children: (iconOnRight == null)
                          ? [
                              Icon(
                                icon,
                                color: (iconColor == null)
                                    ? Colors.white
                                    : iconColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                text,
                                style: TextStyle(
                                    fontSize:
                                        (textSize == null) ? 16 : textSize,
                                    fontWeight: (textWeight == null)
                                        ? FontWeight.w500
                                        : textWeight,
                                    color: (textColor == null)
                                        ? Colors.white
                                        : textColor),
                              ),
                            ]
                          : [
                              Text(
                                text,
                                style: TextStyle(
                                    fontSize:
                                        (textSize == null) ? 16 : textSize,
                                    fontWeight: (textWeight == null)
                                        ? FontWeight.w500
                                        : textWeight,
                                    color: (textColor == null)
                                        ? Colors.white
                                        : textColor),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                icon,
                                color: (iconColor == null)
                                    ? Colors.white
                                    : iconColor,
                              ),
                            ],
                    )
                  : Container(
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: (textSize == null) ? 16 : textSize,
                            fontWeight: (textWeight == null)
                                ? FontWeight.w500
                                : textWeight,
                            color:
                                (textColor == null) ? Colors.white : textColor),
                      ),
                    ),
        ),
      ),
    );
  }
}
