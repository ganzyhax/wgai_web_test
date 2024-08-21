import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';

class PersonalGrowthCard extends StatelessWidget {
  final bool? isFinished;
  final String title;
  final int type;
  const PersonalGrowthCard(
      {super.key,
      this.isFinished = false,
      required this.type,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                (type == 1)
                    ? 'assets/images/personal_frame_1.png'
                    : (type == 2)
                        ? 'assets/images/personal_frame_2.png'
                        : 'assets/images/personal_frame_3.png',
                width: (type == 2) ? 80 : 80,
                height: (type == 2) ? 120 : 80,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: (type == 2)
                    ? EdgeInsets.only(top: 36.0)
                    : EdgeInsets.only(top: 0.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          (isFinished == true)
              ? Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Результаты',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFE5E5EA),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
