import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String description;
  const CustomAlert({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/tick_dynamic_color.png',
                width: 128,
                height: 128,
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: AppTextStyle.heading1
                    .copyWith(color: AppColors.blackForText),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                description,
                style: AppTextStyle.bodyText
                    .copyWith(color: AppColors.grayForText),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              CustomButton(
                text: 'Понятно',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
