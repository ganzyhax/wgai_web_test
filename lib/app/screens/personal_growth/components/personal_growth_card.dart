import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';

class PersonalGrowthCard extends StatelessWidget {
  final bool? isFinished;
  final String title;
  final String subTitle;
  final int type;
  final Function() onTap;
  const PersonalGrowthCard(
      {super.key,
      this.isFinished = false,
      required this.type,
      required this.onTap,
      required this.subTitle,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          subTitle,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
                        )
                      ],
                    ),
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
      ),
    );
  }
}
