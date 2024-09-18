import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
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
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.45,
                child: Text(
                  speciality,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.heading4,
                ),
              ),
            ],
          ),
          GestureDetector(
              onTap: () async {
                BlocProvider.of<ProfileBloc>(context)
                    .add(ProfileSetSpeciality(value: null, code: ''));
                await BookmarkData().clearList(AppHiveConstants.kzUniversities);
              },
              child: Icon(Icons.delete))
        ],
      ),
    );
  }
}
