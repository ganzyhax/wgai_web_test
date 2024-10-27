import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';

class ProgramsCard extends StatelessWidget {
  final String name;
  final String countryCode;
  const ProgramsCard(
      {super.key, required this.name, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/program.svg',
            color: AppColors.primary,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
              ),
              Text(countryCode)
            ],
          ),
        ],
      ),
    );
  }
}
