import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/personal_growth/bloc/personal_bloc.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_card.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_test_card.dart';
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
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
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 19),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  PersonalGrowthTestCard(
                    title: 'Узнай себя',
                    asset: 'assets/icons/brain.svg',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: PersonalGrowthCard(
                            type: 1,
                            title: 'Polyomino Tiling',
                          ),
                        ),
                        Positioned(
                          top:
                              70, // Adjust top position based on previous widget's height
                          left: 0,
                          right: 0,
                          child: PersonalGrowthCard(
                            type: 2,
                            title: 'Infinite Areas',
                          ),
                        ),
                        Positioned(
                          top:
                              200, // Adjust top position based on previous widget's height
                          left: 0,
                          right: 0,
                          child: PersonalGrowthCard(
                            title: 'Guards in the Gallery',
                            type: 3,
                          ),
                        ),
                      ],
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
        },
      ),
    );
  }
}
