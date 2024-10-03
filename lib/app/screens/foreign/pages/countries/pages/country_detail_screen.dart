import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/foreign/pages/countries/widgets/country_expanded_card.dart';
import 'package:wg_app/app/widgets/containers/basic_expanded_container.dart';
import 'package:wg_app/app/widgets/containers/expanded_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class CountryDetailScreen extends StatelessWidget {
  final data;
  const CountryDetailScreen({super.key, required this.data});

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
            LocaleKeys.countries.tr(),
            style: AppTextStyle.titleHeading
                .copyWith(color: AppColors.blackForText),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(data['thumbnail']),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  data['name'][context.locale.languageCode],
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.modules.tr(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              CountryExpandableContainer(
                data: data,
              ),
              SizedBox(
                height: 10,
              ),
              BasicExpandableContainer(
                  title: LocaleKeys.learning.tr(), content: ''),
              SizedBox(
                height: 10,
              ),
              BasicExpandableContainer(
                  title: LocaleKeys.universities.tr(), content: ''),
              SizedBox(
                height: 10,
              ),
              BasicExpandableContainer(
                  title: LocaleKeys.programs.tr(), content: ''),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
