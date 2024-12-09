import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wg_app/app/screens/profile_growth/bloc/profile_growth_bloc.dart';
import 'package:wg_app/app/screens/profile_growth/widgets/growth_card.dart';
import 'package:wg_app/app/screens/profile_growth/widgets/growth_test_card.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileGrowthScreen extends StatelessWidget {
  const ProfileGrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: CustomAppbar(
                title: LocaleKeys.personal_growth.tr(), withBackButton: true)),
        body: BlocProvider(
          create: (context) => ProfileGrowthBloc()..add(ProfileGrowthLoad()),
          child: SingleChildScrollView(
            child: BlocListener<ProfileGrowthBloc, ProfileGrowthState>(
              listener: (context, state) {
                if (state is ProfileGrowthError) {
                  CustomSnackbar()
                      .showCustomSnackbar(context, state.errorText, false);
                }
              },
              child: BlocBuilder<ProfileGrowthBloc, ProfileGrowthState>(
                builder: (context, state) {
                  if (state is ProfileGrowthLoaded) {
                    return Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              children: [
                                GrowthCard(
                                  resultText: state.data['personalGrowth']
                                      ['nextItem'][context.locale.languageCode],
                                  percentage: state.data['personalGrowth']
                                          ['progress']
                                      .toString(),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ListView.builder(
                                    itemCount: state
                                        .data['personalGrowth']['psytests']
                                        .length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return (state.data['personalGrowth']
                                                  ['psytests'][index]
                                              .containsKey(
                                                  'interpretationLink'))
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: GrowthTestCard(
                                                interpretationLink:
                                                    state.data['personalGrowth']
                                                            ['psytests'][index]
                                                        ['interpretationLink'],
                                                icon: "starfour",
                                                title:
                                                    state.data['personalGrowth']
                                                                ['psytests']
                                                            [index]['title'][
                                                        context.locale
                                                            .languageCode],
                                                subTitle: (state
                                                        .data['personalGrowth']
                                                            ['psytests'][index]
                                                        .containsKey(
                                                            'subtitle'))
                                                    ? state.data['personalGrowth']
                                                                ['psytests']
                                                            [index]['subtitle'][
                                                        context.locale
                                                            .languageCode]
                                                    : '',
                                                fullContent:
                                                    state.data['personalGrowth']
                                                                ['psytests']
                                                            [index]['subtitle'][
                                                        context.locale
                                                            .languageCode],
                                              ),
                                            )
                                          : SizedBox.shrink();
                                    })
                              ],
                            )),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
