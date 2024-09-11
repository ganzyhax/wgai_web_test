import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniversityKzSpecialityCard extends StatelessWidget {
  final String speciality;
  const UniversityKzSpecialityCard({super.key, required this.speciality});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Профильный предмет'),
              SizedBox(
                height: 5,
              ),
              Text(
                speciality,
                style: AppTextStyle.heading4,
              ),
            ],
          ),
          Icon(Icons.delete)
        ],
      ),
    );
  }
}
