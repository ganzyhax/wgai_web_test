import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class GrowthTestCard extends StatelessWidget {
  final String title;
  final String subTitle;
  const GrowthTestCard(
      {super.key, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 30,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: AppTextStyle.heading2,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                subTitle,
                style: TextStyle(fontSize: 15, color: Colors.grey[400]),
              )
            ],
          ),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}
