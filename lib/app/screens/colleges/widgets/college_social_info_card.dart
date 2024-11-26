import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CollegeSocialInfoCard extends StatelessWidget {
  final String titleAddress;
  final String address;
  final String titleContacts;
  final List<String> contacts;
  final String titleSocial;
  final List<Map<String, String>> socialMedia;
  final String titleSite;
  final String site;

  const CollegeSocialInfoCard({
    super.key,
    required this.titleAddress,
    required this.address,
    required this.titleContacts,
    required this.contacts,
    required this.titleSocial,
    required this.socialMedia,
    required this.titleSite,
    required this.site,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleAddress,
            style: AppTextStyle.interW600S12
                .copyWith(color: AppColors.blackForText),
          ),
          Text(
            address,
            style: AppTextStyle.bodyTextVerySmall
                .copyWith(color: AppColors.blackForText),
          ),
          const SizedBox(height: 8),
          Text(
            titleContacts,
            style: AppTextStyle.interW600S12
                .copyWith(color: AppColors.blackForText),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contacts.map((contact) {
              return Text(
                contact,
                style: AppTextStyle.bodyTextVerySmall
                    .copyWith(color: AppColors.blackForText),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Text(
            titleSocial,
            style: AppTextStyle.interW600S12
                .copyWith(color: AppColors.blackForText),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: socialMedia.map((social) {
              return Text(
                social['link'] ?? '',
                style: AppTextStyle.bodyTextVerySmall
                    .copyWith(color: AppColors.blackForText),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Text(
            titleSite,
            style: AppTextStyle.interW600S12
                .copyWith(color: AppColors.blackForText),
          ),
          Text(
            site,
            style: AppTextStyle.bodyTextVerySmall
                .copyWith(color: AppColors.blackForText),
          ),
        ],
      ),
    );
  }
}
