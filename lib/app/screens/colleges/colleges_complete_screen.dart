import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/screens/colleges/bloc/colleges_bloc.dart';
import 'package:wg_app/app/screens/colleges/widgets/college_info_card.dart';
import 'package:wg_app/app/screens/colleges/widgets/college_social_info_card.dart';
import 'package:wg_app/app/screens/colleges/widgets/college_special_container.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_special_container.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class CollegesCompleteScreen extends StatelessWidget {
  final college;
  const CollegesCompleteScreen({super.key, required this.college});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(
            title: LocaleKeys.universities.tr(),
            withBackButton: true,
          )),
      body: SingleChildScrollView(
        child: BlocBuilder<CollegesBloc, CollegesState>(
          builder: (context, state) {
            if (state is CollegesLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CollegeInfoCard(
                      icon: PhosphorIconsRegular.bank,
                      code: college['code'] ?? '',
                      title: college['name'][context.locale.languageCode] ?? '',
                      description: college['description']
                              [context.locale.languageCode] ??
                          '',
                      hasDormitory: college['hasDormitory'] ?? false,
                      hasMilitaryDept: college['hasMilitaryDept'] ?? false,
                      // type: college['type'][context.locale.languageCode] ?? '',
                      isUnivesity: true,
                    ),
                    const SizedBox(height: 16),
                    CollegeSocialInfoCard(
                        titleAddress: LocaleKeys.adress.tr() + ':',
                        address: college['address']
                                [context.locale.languageCode] ??
                            '',
                        titleContacts: LocaleKeys.contacts.tr() + ':',
                        contacts: [],
                        titleSocial: LocaleKeys.social_media.tr() + ':',
                        socialMedia: college['socialMedia']
                                ?.map((social) => {'link': social.link ?? ''})
                                .toList() ??
                            [],
                        titleSite: LocaleKeys.website.tr(),
                        site: college['website'] ?? ''),
                    const SizedBox(height: 16),
                    Column(
                      children: state.specialities?.map<Widget>((specialty) {
                            final match = college['specialties']?.any(
                                (spec) => spec['code'] == specialty['code']);

                            return (match)
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: CollegeSpecialContainer(
                                        onTap: () {
                                          // if (widget.isChooseUniversity ==
                                          //     null) {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           SpecialitiesCompleteScreen(
                                          //               dontShowUniversities:
                                          //                   true,
                                          //               data: spec!,
                                          //               speciesId: specialty
                                          //                       .code ?? ad
                                          //                   '')),
                                          // );
                                          // }
                                        },
                                        codeNumber: specialty['code'],
                                        title: specialty['name']
                                            [context.locale.languageCode],
                                        subject: ''))
                                : SizedBox();
                          }).toList() ??
                          [],
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
