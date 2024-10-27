import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wg_app/app/screens/personal_growth/personal_growth_screen.dart'; // Make sure this import is correct
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
class GrowthCard extends StatelessWidget {
  final String percentage;
  final String resultText;

  const GrowthCard({
    Key? key,
    required this.percentage,
    required this.resultText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.personal_growth.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {
              // pop 3 times just in case
              for (int i = 0; i < 3; i++) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  break; // Exit the loop if we can't pop anymore
                }
              }
              BlocProvider.of<MainNavigatorBloc>(context)
                              .add(MainNavigatorChangePage(index: 0));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      resultText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
