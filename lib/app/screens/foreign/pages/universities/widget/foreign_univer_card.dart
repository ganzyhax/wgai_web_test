import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/pages/foreign_unversity_detail.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForeignUniverCard extends StatelessWidget {
  final data;
  const ForeignUniverCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForeignUnversityDetail(
              data: data,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/universities.svg',
              color: AppColors.primary,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    data['name'][context.locale.languageCode],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstant.countriesCode[data['countryCode']]![
                          context.locale.languageCode]!,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    Text('', style: TextStyle(color: Colors.grey[400])),
                    Text(
                      'fEE',
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
