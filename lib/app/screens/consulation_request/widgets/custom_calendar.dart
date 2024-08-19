import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: AppColors.containerBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 19),
        child: Column(
          children: [
            _buildMonthHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                color: AppColors.containerBorder,
                height: 1,
              ),
            ),
            _buildDayLabels(),
            SizedBox(height: 8),
            _buildDaysGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthHeader() {
    final month = DateFormat.MMMM().format(_currentDate);
    final capitalizedMonth = month[0].toUpperCase() + month.substring(1);

    return Text(
      capitalizedMonth,
      style: AppTextStyle.heading2.copyWith(color: AppColors.alternativeBlack),
    );
  }

  Widget _buildDayLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final dayName = DateFormat.E()
            .format(
              DateTime(2024, 1, index + 1),
            )
            .toUpperCase();
        return Expanded(
          child: Center(
            child: Text(
              dayName,
              style: AppTextStyle.bodyText
                  .copyWith(color: AppColors.calendarTextColor),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDaysGrid() {
    final firstDayMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final daysInMonth =
        DateUtils.getDaysInMonth(_currentDate.year, _currentDate.month);
    final firstWeekday = firstDayMonth.weekday;

    List<Widget> dayWidgets = [];

    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(SizedBox(width: 32, height: 32));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDay = DateTime(_currentDate.year, _currentDate.month, day);
      final isWeekend = currentDay.weekday == 6 || currentDay.weekday == 7;

      dayWidgets.add(
        SizedBox(
          width: 32,
          height: 32,
          child: GestureDetector(
            onTap: isWeekend ? null : () => _onDaySelected(currentDay),
            child: Container(
              child: Center(
                child: Text(
                  day.toString(),
                  style: AppTextStyle.bodyText
                      .copyWith(color: isWeekend ? Colors.grey : Colors.black),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: dayWidgets,
    );
  }

  void _onDaySelected(DateTime day) {
    // Handle day selection
    print('Selected day: $day');
  }
}
