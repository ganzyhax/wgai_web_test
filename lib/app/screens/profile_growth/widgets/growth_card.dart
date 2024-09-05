import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

class GrowthCard extends StatelessWidget {
  final String percentage;
  final String resultText;
  const GrowthCard(
      {super.key, required this.percentage, required this.resultText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Личный рост',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              Text(
                percentage + '%',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          CustomButton(
            text: resultText,
            iconOnRight: true,
            onTap: () {},
            textSize: 18,
            textWeight: FontWeight.w700,
            icon: Icons.keyboard_arrow_right,
            bgColor: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
