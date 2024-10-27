import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/pages/foreign_unversity_detail.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForeignUniverCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const ForeignUniverCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForeignUnversityDetail(data: data),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icons/universities.svg',
              color: AppColors.primary,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'][context.locale.languageCode],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 17),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          AppConstant.countriesCode[data['countryCode']]![
                              context.locale.languageCode]!,
                          style: TextStyle(color: Colors.grey[400]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        LocaleKeys.tuitionFee.tr() +
                            ': \$${data['tuitionFeeUSD']}',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
