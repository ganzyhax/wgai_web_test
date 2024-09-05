import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class SpecialitiesScreen extends StatelessWidget {
  const SpecialitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,

        title: Text(
          'Специальности'.tr(),
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        //        BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
        //   builder: (context, state) {
        //     if (state is SpecialitiesLoaded) {

        //     } else {
        //       const CircularProgressIndicator();
        //     }
        //   },
        // )
      ),
      body:
          //BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
          //   builder: (context, state) {
          //     if (state is SpecialitiesLoaded) {

          //     }
          //   },
          // ),
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Специальности'.tr(),
                  style: AppTextStyle.heading2
                      .copyWith(color: AppColors.blackForText),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.filterGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Все предметы'.tr(),
                        style: AppTextStyle.heading4
                            .copyWith(color: AppColors.calendarTextColor),
                      ),
                      SizedBox(width: 4),
                      SvgPicture.asset('assets/icons/expand_down.svg')
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
                builder: (context, state) {
                  if (state is SpecialitiesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SpecialitiesLoaded) {
                    return ListView.builder(
                      itemCount: state.specialResources?.length,
                      itemBuilder: (context, index) {
                        final specialResources = state.specialResources?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: UniContainers(
                            codeNumber: specialResources?.code ?? '',
                            title: specialResources?.name
                                    ?.getLocalizedString(context) ??
                                '',
                            firstDescription: specialResources
                                    ?.profileSubjects?[0].name
                                    ?.getLocalizedString(context) ??
                                '',
                            secondDescription: specialResources
                                    ?.grants?.general?.grantsTotal ??
                                0,
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  } else if (state is SpecialitiesError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
