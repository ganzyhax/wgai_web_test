import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/atlas/atlas_screen.dart';
import 'package:wg_app/app/screens/foreign/pages/countries/country_screen.dart';
import 'package:wg_app/app/screens/foreign/pages/programs/programs_screen.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/foreign_universities_screen.dart';
import 'package:wg_app/app/screens/resources/widgets/resources_container.dart';
import 'package:wg_app/app/screens/specialities/specialities_screen.dart';
import 'package:wg_app/app/screens/universities/universities_screen.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForeignScreen extends StatelessWidget {
  const ForeignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.background,
            centerTitle: false,
            titleSpacing: 16,
            title: Text(
              LocaleKeys.abroad.tr(),
              style: AppTextStyle.titleHeading
                  .copyWith(color: AppColors.blackForText),
            )),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ResourcesContainer(
                title: LocaleKeys.countries.tr(),
                // subTitle: 'Различные тесты для познания самого себя'.tr(),
                subTitle: '',
                iconPath: 'assets/icons/country.svg',
                height: 122,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountryScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ResourcesContainer(
                title: LocaleKeys.all_universities.tr(),
                // subTitle: 'Вузы итд'.tr(),
                subTitle: '',
                iconPath: 'assets/icons/universities.svg',
                height: 122,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForeignUniversitiesScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ResourcesContainer(
                title: LocaleKeys.programs.tr(),
                // subTitle: 'Вузы итд'.tr(),
                subTitle: 'Различные тесты для познания самого себя ',
                iconPath: 'assets/icons/program.svg',
                height: 122,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForeignProgramsScreen(),
                    ),
                  );
                },
              ),
              // const SizedBox(height: 8),
              // ResourcesContainer(
              //   title: LocaleKeys.specialities.tr(),
              //   // subTitle: 'Различные тесты для познания самого себя'.tr(),
              //   subTitle: '',
              //   iconPath: 'assets/icons/specialties.svg',
              //   height: 122,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => SpecialitiesScreen(),
              //       ),
              //     );
              //   },
              // ),

              // const SizedBox(height: 8),
              // ResourcesContainer(
              //   title: LocaleKeys.admission_nu.tr(),
              //   subTitle: 'Различные тесты для познания самого себя',
              //   iconPath: 'assets/icons/nazarbaev.svg',
              //   height: 122,
              //   onTap: () {
              //     print('Go to nu prep');
              //   },
              // ),
              const SizedBox(height: 8),
            ],
          ),
        )));
  }
}
