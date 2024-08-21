import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ConsultantScreen extends StatelessWidget {
  const ConsultantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                ),
                _buildHedear(),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 7,
                    child: Image.asset(
                      'assets/images/splash_image.png',
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Добрый день, Адилет!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ));
  }

  _buildHedear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'WEGLOBAL.AI',
          style: AppTextStyle.heading1,
        ),
        Row(
          children: [
            Icon(Icons.notifications_outlined),
            SizedBox(
              width: 25,
            ),
            Icon(Icons.message_outlined),
          ],
        )
      ],
    );
  }
}
