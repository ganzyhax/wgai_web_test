import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';

class AiQuestionsCard extends StatelessWidget {
  final String title;
  final String description;
  const AiQuestionsCard(
      {super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width / 2.13,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteForText),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17, color: Colors.grey.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
