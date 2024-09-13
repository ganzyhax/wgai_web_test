import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/specialities/model/kaz_specialities.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class GrantsContainer extends StatefulWidget {
  final String title;
  final String year;
  final bool isResults;
  final List<GrantScores> grantItems;
  final int grantTotal;
  const GrantsContainer(
      {super.key,
      required this.title,
      this.year = 'Год',
      required this.isResults,
      required this.grantItems,
      required this.grantTotal});

  @override
  State<GrantsContainer> createState() => _GrantsContainerState();
}

class _GrantsContainerState extends State<GrantsContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(children: [
            Text(
              widget.title,
              style: AppTextStyle.heading3.copyWith(color: AppColors.calendarTextColor),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon:
                  _isExpanded ? SvgPicture.asset('assets/icons/caret-down.svg') : SvgPicture.asset('assets/icons/caret-top.svg'),
            ),
          ]),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                widget.year,
                style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
              ),
              const Spacer(),
              if (widget.isResults) ...[
                Text(
                  'мин',
                  style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
                ),
                const SizedBox(width: 24),
                Text(
                  'макс',
                  style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
                ),
              ],
              if (!widget.isResults)
                Text(
                  'Количество грантов',
                  style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
                ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(
            height: 1,
            color: AppColors.grayForText,
          ),
          const SizedBox(height: 8),
          if (_isExpanded) ...[
            const SizedBox(height: 8),
            Column(
              children: widget.grantItems.map((grant) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${grant.year}',
                        style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
                      ),
                      if (widget.isResults)
                        Row(
                          children: [
                            SizedBox(
                              width: 25,
                              child: Text(
                                '${grant.min}',
                                style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
                              ),
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              width: 25,
                              child: Text(
                                '${grant.max}',
                                style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
                              ),
                            ),
                          ],
                        ),
                      if (!widget.isResults)
                        Text(
                          '${widget.grantTotal}',
                          style: AppTextStyle.bodyTextSmall.copyWith(color: AppColors.grayForText),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
