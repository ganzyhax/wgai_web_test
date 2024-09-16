import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class PersonalGrowthCard extends StatelessWidget {
  final bool? isFinished;
  final String title;
  final String subTitle;
  final int type;
  final Function() onTap;
  final bool? isTesting;

  const PersonalGrowthCard({
    Key? key,
    this.isFinished = false,
    required this.type,
    required this.onTap,
    required this.subTitle,
    required this.title,
    this.isTesting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    (type == 1)
                        ? 'assets/images/personal_frame_1.png'
                        : (type == 2)
                            ? 'assets/images/personal_frame_2.png'
                            : 'assets/images/personal_frame_3.png',
                    width: 80,
                    height: (type == 2) ? 120 : 80,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isFinished == true && isTesting == true)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  LocaleKeys.personalGrowthResultsButton.tr(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFFE5E5EA),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          subTitle,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
