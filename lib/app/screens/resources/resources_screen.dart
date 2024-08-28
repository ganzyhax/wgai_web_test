import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/atlas/atlas_screen.dart';
import 'package:wg_app/app/screens/resources/widgets/resources_container.dart';
import 'package:wg_app/app/screens/specialities/specialities_screen.dart';
import 'package:wg_app/app/screens/universities/universities_screen.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

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
              'Ресурсы',
              style: AppTextStyle.titleHeading
                  .copyWith(color: AppColors.blackForText),
            )),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ResourcesContainer(
                title: 'Атлас Профессий',
                subTitle: 'Различные тесты для познания самого себя',
                iconPath: 'assets/icons/atlas.svg',
                height: 122,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AtlasScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ResourcesContainer(
                title: 'ВУЗ-ы',
                subTitle: 'Вузы итд',
                iconPath: 'assets/icons/universities.svg',
                height: 122,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UniversitiesScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ResourcesContainer(
                title: 'Cпециальности',
                subTitle: 'Различные тесты для познания самого себя',
                iconPath: 'assets/icons/specialties.svg',
                height: 122,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpecialitiesScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ResourcesContainer(
                title: 'ЕНТ',
                subTitle: 'Различные тесты для познания самого себя',
                iconPath: 'assets/icons/resources.svg',
                height: 122,
                onTap: () {
                  print('Go to ent');
                },
              ),
              const SizedBox(height: 8),
              ResourcesContainer(
                title: 'Поступление в НУ',
                subTitle: 'Различные тесты для познания самого себя',
                iconPath: 'assets/icons/nazarbaev.svg',
                height: 122,
                onTap: () {
                  print('Go to nu prep');
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        )));
  }
}
