import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class UniversitySpecialSelectModal extends StatelessWidget {
  const UniversitySpecialSelectModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.background,
                  ),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              LocaleKeys.chooseProfileSubjects.tr(),
                              style: AppTextStyle.heading1,
                            ),
                          ),
                          Icon(Icons.close),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        LocaleKeys.pleaseChooseProfileSubjects.tr(),
                        style: AppTextStyle.bodyText,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.specialities.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ProfileBloc>(context).add(
                                      ProfileSetSpeciality(
                                          value: state.specialities[index]
                                              ['name']['kk']));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: (state.selectedSpeciality ==
                                              state.specialities[index]['name']
                                                  ['kk'])
                                          ? AppColors.primary.withOpacity(0.3)
                                          : Colors.white),
                                  child: Text(
                                    state.specialities[index]['name']['kk'],
                                    style: AppTextStyle.heading3,
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 0, // Align left
                  right: 0, // Align right
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: CustomButton(
                        text: LocaleKeys.choose.tr(),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        height: 50,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
