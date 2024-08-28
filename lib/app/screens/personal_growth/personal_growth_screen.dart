import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/personal_growth/bloc/personal_bloc.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_card.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_test_card.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/webview/html_webview.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class PersonalGrowthScreen extends StatelessWidget {
  const PersonalGrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<PersonalBloc, PersonalState>(
        builder: (context, state) {
          return BlocBuilder<PersonalBloc, PersonalState>(
            builder: (context, state) {
              if (state is PersonalLoaded) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Text(
                            'Личный рост',
                            style: AppTextStyle.heading1,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Личный рост',
                                style: AppTextStyle.heading1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Take a peek under the hood of large language models \n(LLMs) to understand how they work.',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 19),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: PersonalGrowthTestCard(
                            title: 'Узнай себя',
                            asset: 'assets/icons/brain.svg',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: calculateDynamicHeight(state.data),
                          child: Stack(
                            children:
                                state.data.asMap().entries.map<Widget>((entry) {
                              int index = entry.key;
                              var e = entry.value;

                              double topPosition = 0;
                              for (int i = 0; i < index; i++) {
                                var prevItem = state.data[i];
                                topPosition +=
                                    (prevItem['availabilityStatus'] == 'locked')
                                        ? 90.0
                                        : 140.0;
                              }

                              return Positioned(
                                top:
                                    topPosition, // Adjust top position based on accumulated height
                                left: 0,
                                right: 0,

                                child: PersonalGrowthCard(
                                  onTap: () {
                                    if (e['availabilityStatus'] != 'locked' &&
                                        e['type'] == 'reading') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HtmlWebView(
                                                  contentCode: e['contentCode'],
                                                )),
                                      );
                                    }
                                    if (e['type'] == 'testing') {}
                                  },
                                  subTitle: e['subTitle']['ru'],
                                  type: (e['availabilityStatus'] == 'locked')
                                      ? 3
                                      : (e['completionStatus'] == 'new')
                                          ? 2
                                          : 1,
                                  isFinished: (e['availabilityStatus'] !=
                                              'locked' &&
                                          (e['completionStatus'] == 'complete'))
                                      ? true
                                      : false,
                                  title: e['title'][
                                      'ru'], // Example usage, assuming 'title' is a key in your data
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        PersonalGrowthTestCard(
                          title: 'Рынок труда',
                          asset: 'assets/icons/briefcase.svg',
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }

  double calculateDynamicHeight(List<dynamic> data) {
    double totalHeight = 0;
    for (var item in data) {
      // Cast item to Map<String, dynamic> if needed
      final Map<String, dynamic> mapItem = item as Map<String, dynamic>;
      if (mapItem['availabilityStatus'] == 'locked') {
        totalHeight += 90.0; // Height for locked items
      } else {
        totalHeight += 140.0; // Height for available items
      }
    }
    return totalHeight;
  }
}
