import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wg_app/constants/app_text_style.dart';

class PersonalGrowthTestCard extends StatelessWidget {
  final String asset;
  final String title;
  const PersonalGrowthTestCard(
      {super.key, required this.asset, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFE5E5EA),
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            width: 35,
            height: 35,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: AppTextStyle.heading1,
          )
        ],
      ),
    );
  }
}
