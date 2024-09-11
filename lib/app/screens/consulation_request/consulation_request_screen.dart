import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/consulation_request/bloc/consulation_request_bloc.dart';
import 'package:wg_app/app/screens/consulation_request/widgets/custom_calendar.dart';
import 'package:wg_app/app/screens/consulation_request/widgets/time_slot_widget.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ConsulationRequestScreen extends StatefulWidget {
  const ConsulationRequestScreen({super.key});

  @override
  State<ConsulationRequestScreen> createState() => _ConsulationRequestScreenState();
}

class _ConsulationRequestScreenState extends State<ConsulationRequestScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: BlocBuilder<ConsulationRequestBloc, ConsulationRequestState>(
          builder: (context, state) {
            if (state is ConsulationRequestInitial) {
              return _buildInitialContent();
            }
            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildInitialContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.request_advice.tr(),
                style: AppTextStyle.heading2.copyWith(color: AppColors.alternativeBlack),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset('assets/icons/rounded_x.svg'),
              )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: AppColors.containerBorder),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Image.asset('assets/images/avatar.png'),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Text(
                        'Adilet Degitayev',
                        style: AppTextStyle.heading3.copyWith(color: AppColors.blackForText),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(Профориентатор)', //Change
                        style: AppTextStyle.bodyTextSmall.copyWith(
                          color: AppColors.alternativeGray,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            LocaleKeys.select_data.tr(),
            style: AppTextStyle.heading2.copyWith(color: AppColors.alternativeBlack),
          ),
          const SizedBox(height: 24),
          CustomCalendar(),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.select_slot.tr(),
            style: AppTextStyle.heading2.copyWith(color: AppColors.alternativeBlack),
          ),
          const SizedBox(height: 16),
          const TimeSlotWidget(),
          const SizedBox(height: 24),
          Text(
            LocaleKeys.choose_topic_consulation.tr(),
            style: AppTextStyle.heading2.copyWith(color: AppColors.alternativeBlack),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.slotColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                maintainState: true,
                collapsedBackgroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                tilePadding: const EdgeInsets.symmetric(horizontal: 12.0),
                childrenPadding: EdgeInsets.zero,
                title: Text(
                  LocaleKeys.select_data.tr(),
                  style: AppTextStyle.bodyText.copyWith(color: AppColors.grayForText),
                ),
                children: [
                  Container(
                    height: 272.0,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Item $index'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: LocaleKeys.sign_up_consulation.tr(),
            onTap: () {
              print('tapped');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
