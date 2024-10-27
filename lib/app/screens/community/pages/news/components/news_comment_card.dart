import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';

class NewsCommentCard extends StatelessWidget {
  const NewsCommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.background,
      ),
    );
  }
}
