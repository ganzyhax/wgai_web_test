import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/atlas/atlas_complete_screen.dart';
import 'package:wg_app/app/screens/foreign/pages/countries/bloc/country_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/countries/pages/country_detail_screen.dart';
import 'package:wg_app/app/screens/foreign/pages/countries/widgets/country_card.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class CountryScreen extends StatelessWidget {
  const CountryScreen({super.key});

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
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3, // 3 items per row
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      children:
                          List.generate(state.data['data'].length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryDetailScreen(
                                  data: state.data['data'][index],
                                ),
                              ),
                            );
                          },
                          child: CountryCard(
                              icon: state.data['data'][index]['code'],
                              text: state.data['data'][index]['name']
                                  [context.locale.languageCode]),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
