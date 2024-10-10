import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

class AiLastDialogCard extends StatelessWidget {
  final String title;
  final String description;

  const AiLastDialogCard(
      {super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: AppColors.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomButton(
            bgColor: Colors.white,
            text: 'Dialog otu',
            spaceBetweenOnIcon: true,
            onTap: () {},
            textColor: AppColors.primary,
            iconColor: AppColors.primary,
            icon: Icons.keyboard_arrow_right,
            iconOnRight: true,
          ),
        ],
      ),
    );
  }
}
