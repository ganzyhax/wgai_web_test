import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/app/screens/consultation_request/model/slot_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/consultation_request/bloc/consultation_request_bloc.dart';
import 'package:wg_app/app/screens/consultation_request/model/slot_model.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class TimeSlotWidget extends StatelessWidget {
  final List<SlotModel> slots;
  final DateTime selectedDay;

  const TimeSlotWidget({
    Key? key,
    required this.slots,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredSlots = slots.where((slot) {
      return slot.startDate.year == selectedDay.year &&
             slot.startDate.month == selectedDay.month &&
             slot.startDate.day == selectedDay.day;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filteredSlots.map((slot) {
        final isBooked = slot.isBooked;
        final isSelected = slot.isSelected;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: isBooked
                ? null
                : () {
                    context.read<ConsultationRequestBloc>().add(SelectSlot(slot.id));
                  },
            child: Container(
              decoration: BoxDecoration(
                color: isBooked
                    ? Colors.grey[300]
                    : (isSelected ? AppColors.primary : Colors.white),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isBooked
                      ? Colors.grey[300]!
                      : (isSelected ? AppColors.primary : Colors.grey[400]!),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    slot.formattedTimeSlot,
                    style: AppTextStyle.bodyText.copyWith(
                      color: isBooked
                          ? Colors.grey[600]
                          : (isSelected ? Colors.white : AppColors.blackForText),
                    ),
                  ),
                  if (isBooked)
                    const Icon(Icons.block, color: Colors.grey)
                  else if (isSelected)
                    const Icon(Icons.check_circle, color: Colors.white)
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}