import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_kz_speciality_card.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_kz_type_card.dart';
import 'package:wg_app/app/screens/specialities/specialities_screen.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/universities_screen.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniversityKzStorageContainer extends StatefulWidget {
  final String title;
  final String mySpeciality;

  const UniversityKzStorageContainer(
      {super.key, required this.title, required this.mySpeciality});

  @override
  State<UniversityKzStorageContainer> createState() =>
      _UniversityKzStorageContainerState();
}

class _UniversityKzStorageContainerState
    extends State<UniversityKzStorageContainer> {
  @override
  Widget build(BuildContext context) {
    var data = BookmarkData().getItems(AppHiveConstants.kzUniversities);

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/chalkboard_teacher.svg'),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTextStyle.heading3
                      .copyWith(color: AppColors.calendarTextColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          (widget.mySpeciality != '')
              ? UniversityKzSpecialityCard(speciality: widget.mySpeciality)
              : SizedBox(),
          Divider(),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (data.length > 5) ? 5 : data.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final IconData? resolvedIcon =
                    myIconMap[data[index]['data']['areaIconCode']];
                return UniversityKzTypeCard(
                    type: data[index]['data']['type'],
                    universityCode: data[index]['data']['universityCode'],
                    universityName: data[index]['data']['title']);
              }),
          const SizedBox(height: 15),
          (data.length > 5)
              ? CustomButton(
                  text: 'View All',
                  bgColor: AppColors.background,
                  textColor: Colors.black,
                  onTap: () {},
                )
              : SizedBox(),
          CustomButton(
              text: 'Browse universities',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpecialitiesScreen()),
                );

                setState(() {
                  data = data = BookmarkData().getItems(AppHiveConstants
                      .kzUniversities); // Update state with result
                });
              })
        ],
      ),
    );
  }
}
