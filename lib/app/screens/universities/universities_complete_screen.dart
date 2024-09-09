import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/screens/specialities/specialities_complete_screen.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_complete.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_social_container.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_special_container.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniversitiesCompleteScreen extends StatefulWidget {
  final String universityId;
  const UniversitiesCompleteScreen({super.key, required this.universityId});

  @override
  State<UniversitiesCompleteScreen> createState() => _UniversitiesCompleteScreenState();
}

class _UniversitiesCompleteScreenState extends State<UniversitiesCompleteScreen> {
  late bool isBookmarked;

  @override
  void initState() {
    isBookmarked = BookmarkData().containsItem(AppHiveConstants.kzUniversities, widget.universityId);
    log(isBookmarked.toString());
    super.initState();
  }

  void toggleBookmark() async {
    if (!isBookmarked) {
      await BookmarkData().addItem(AppHiveConstants.kzUniversities, widget.universityId);
    } else {
      await BookmarkData().removeItem(AppHiveConstants.kzUniversities, widget.universityId);
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ВУЗ'),
        actions: [
          IconButton(
            onPressed: () {
              toggleBookmark();
              print('Id: ${widget.universityId}');
            },
            icon: isBookmarked ? SvgPicture.asset('assets/icons/bookmark.svg') : const PhosphorIcon(PhosphorIconsBold.bookmark),
          ),
        ],
      ),
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
                        title: university.name?.getLocalizedString(context) ?? '',
                        description: university.description?.getLocalizedString(context) ?? '',
                        hasDormitory: university.hasDormitory ?? false,
                        hasMilitaryDept: university.hasMilitaryDept ?? false,
                        type: university.type?.getLocalizedString(context) ?? '',
                      ),
                      const SizedBox(height: 16),
                      UniSocialContainer(
                          titleAddress: "Адрес:",
                          address: university.address?.getLocalizedString(context) ?? '',
                          titleContacts: "Контакты:",
                          contacts: university.phoneNumbers ?? [],
                          titleSocial: "Соц. сеть:",
                          socialMedia: university.socialMedia?.map((social) => {'link': social.link ?? ''}).toList() ?? [],
                          titleSite: "Сайт:",
                          site: university.website ?? ''),
                      const SizedBox(height: 16),
                      Text(
                        'Cпециальности',
                        style: AppTextStyle.heading3,
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: university.specialties?.map((specialty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: UniSpecialContainer(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SpecialitiesCompleteScreen(speciesId: specialty.code ?? '')),
                                      );
                                    },
                                    codeNumber: specialty.code ?? '',
                                    title: specialty.name?.getLocalizedString(context) ?? '',
                                    subject: "Subject Placeholder",
                                    grantScore: 90,
                                    paidScore: 70),
                              );
                            }).toList() ??
                            [],
                      ),
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
