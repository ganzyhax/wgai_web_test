import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/specialities/model/kaz_specialities.dart';
import 'package:wg_app/app/screens/specialities/specialities_complete_screen.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_complete.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_social_container.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_special_container.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniversitiesCompleteScreen extends StatefulWidget {
  final String universityId;
  final bool? isChooseUniversity;
  const UniversitiesCompleteScreen(
      {super.key, required this.universityId, this.isChooseUniversity});

  @override
  State<UniversitiesCompleteScreen> createState() =>
      _UniversitiesCompleteScreenState();
}

class _UniversitiesCompleteScreenState
    extends State<UniversitiesCompleteScreen> {
  late bool isBookmarked;
  late String type;
  @override
  void initState() {
    type = BookmarkData()
        .getDataType(AppHiveConstants.kzUniversities, widget.universityId);

    isBookmarked = BookmarkData()
        .containsItem(AppHiveConstants.kzUniversities, widget.universityId);

    super.initState();

    context.read<SpecialitiesBloc>().add(LoadSpecialities());
  }

  void toggleBookmark() async {
    if (!isBookmarked) {
      await BookmarkData().addItem(AppHiveConstants.kzUniversities,
          {'id': widget.universityId, 'data': widget.universityId});
    } else {
      await BookmarkData()
          .removeItem(AppHiveConstants.kzUniversities, widget.universityId);
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(
            title: 'ВУЗ',
            withBackButton: true,
            actions: [
              IconButton(
                onPressed: () {
                  toggleBookmark();
                  print('Id: ${widget.universityId}');
                },
                icon: isBookmarked
                    ? SvgPicture.asset('assets/icons/bookmark.svg')
                    : SvgPicture.asset('assets/icons/bookmark-open.svg'),
              ),
            ],
          )),
      body: BlocBuilder<UniversitiesBloc, UniversitiesState>(
        builder: (context, state) {
          if (state is UniversitiesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UniversitiesLoaded) {
            final university = state.universities?.firstWhere(
              (uni) => uni.code == widget.universityId,
              orElse: () => Universities(),
            );

            if (university != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UniComplete(
                        icon: PhosphorIconsRegular.bank,
                        code: university.code ?? '',
                        title:
                            university.name?.getLocalizedString(context) ?? '',
                        description: university.description
                                ?.getLocalizedString(context) ??
                            '',
                        hasDormitory: university.hasDormitory ?? false,
                        hasMilitaryDept: university.hasMilitaryDept ?? false,
                        type:
                            university.type?.getLocalizedString(context) ?? '',
                        isUnivesity: true,
                      ),
                      const SizedBox(height: 16),
                      UniSocialContainer(
                          titleAddress: "Адрес:",
                          address:
                              university.address?.getLocalizedString(context) ??
                                  '',
                          titleContacts: "Контакты:",
                          contacts: university.phoneNumbers ?? [],
                          titleSocial: "Соц. сеть:",
                          socialMedia: university.socialMedia
                                  ?.map((social) => {'link': social.link ?? ''})
                                  .toList() ??
                              [],
                          titleSite: "Сайт:",
                          site: university.website ?? ''),
                      const SizedBox(height: 16),
                      const Text(
                        'Cпециальности',
                        style: AppTextStyle.heading3,
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
                        builder: (context, state) {
                          if (state is SpecialitiesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SpecialitiesLoaded) {
                            return Column(
                              children:
                                  university.specialties?.map((specialty) {
                                        final spec =
                                            state.specialResources?.firstWhere(
                                          (spec) => spec.code == specialty.code,
                                          orElse: () =>
                                              Specialties(code: specialty.code),
                                        );
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: UniSpecialContainer(
                                              onTap: () {
                                                if (widget.isChooseUniversity ==
                                                    null) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SpecialitiesCompleteScreen(
                                                                speciesId: specialty
                                                                        .code ??
                                                                    '')),
                                                  );
                                                }
                                              },
                                              codeNumber: specialty.code ?? '',
                                              title: spec?.name
                                                      ?.getLocalizedString(
                                                          context) ??
                                                  '',
                                              subject: (spec?.profileSubjects ==
                                                      null)
                                                  ? ''
                                                  : spec?.profileSubjects?[0]
                                                          .name
                                                          ?.getLocalizedString(
                                                              context) ??
                                                      '',
                                              grantScore: spec?.grants?.general
                                                      ?.grantScores?[0].max ??
                                                  0,
                                              paidScore: spec?.grants?.general
                                                      ?.grantScores?[0].max ??
                                                  0),
                                        );
                                      }).toList() ??
                                      [],
                            );
                          } else if (state is SpecialitiesError) {
                            return Center(child: Text(state.message));
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomButton(
                          isDisabled: (type == 'dream') ? true : false,
                          text: (type == 'dream')
                              ? 'Selected for target Dream'
                              : 'Select for target Dream',
                          onTap: () async {
                            await BookmarkData().removeItem(
                                AppHiveConstants.kzUniversities,
                                widget.universityId);
                            await BookmarkData()
                                .addItem(AppHiveConstants.kzUniversities, {
                              'id': widget.universityId,
                              'data': {
                                'universityCode': university?.code,
                                'title': university.name!.toJson(),
                                'type': 'dream'
                              }
                            });
                            type = BookmarkData().getDataType(
                                AppHiveConstants.kzUniversities,
                                widget.universityId);

                            setState(() {});
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      CustomButton(
                          isDisabled: (type == 'target') ? true : false,
                          text: (type == 'target')
                              ? 'Selected for target Choice'
                              : 'Select for target Choice',
                          onTap: () async {
                            await BookmarkData().removeItem(
                                AppHiveConstants.kzUniversities,
                                widget.universityId);
                            await BookmarkData()
                                .addItem(AppHiveConstants.kzUniversities, {
                              'id': widget.universityId,
                              'data': {
                                'universityCode': university?.code,
                                'title': university.name!.toJson(),
                                'type': 'target'
                              }
                            });

                            type = BookmarkData().getDataType(
                                AppHiveConstants.kzUniversities,
                                widget.universityId);

                            setState(() {});
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      CustomButton(
                          isDisabled: (type == 'safe') ? true : false,
                          text: (type == 'safe')
                              ? 'Selected for target Safe'
                              : 'Select for target Safe',
                          onTap: () async {
                            await BookmarkData().removeItem(
                                AppHiveConstants.kzUniversities,
                                widget.universityId);
                            await BookmarkData()
                                .addItem(AppHiveConstants.kzUniversities, {
                              'id': widget.universityId,
                              'data': {
                                'universityCode': university?.code,
                                'title': university.name!.toJson(),
                                'type': 'safe'
                              }
                            });

                            type = BookmarkData().getDataType(
                                AppHiveConstants.kzUniversities,
                                widget.universityId);

                            setState(() {});
                          }),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('University not found'));
            }
          } else if (state is UniversitiesError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
