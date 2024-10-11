import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime, DateTime, DateTime) onDaySelected;
  final String language;
  final List<DateTime> availableDates;
  final List<DateTime> bookedDates;  // New parameter for fully booked dates
  
  const CustomCalendar({
    Key? key,
    required this.onDaySelected,
    required this.language,
    required this.availableDates,
    required this.bookedDates,  // Add this line
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;

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
    final month = DateFormat.MMMM(widget.language).format(_currentDate);
    final capitalizedMonth = month[0].toUpperCase() + month.substring(1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => _changeMonth(-1),
        ),
        Text(
          capitalizedMonth,
          style: AppTextStyle.heading2.copyWith(color: AppColors.alternativeBlack),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 18),
          onPressed: () => _changeMonth(1),
        ),
      ],
    );
  }

  Widget _buildDayLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final dayName = DateFormat.E(widget.language)
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
      final isSelected = _selectedDate != null &&
          currentDay.year == _selectedDate!.year &&
          currentDay.month == _selectedDate!.month &&
          currentDay.day == _selectedDate!.day;
      final hasAvailableSlot = widget.availableDates.any((date) =>
          date.year == currentDay.year &&
          date.month == currentDay.month &&
          date.day == currentDay.day);
      final isFullyBooked = widget.bookedDates.any((date) =>
          date.year == currentDay.year &&
          date.month == currentDay.month &&
          date.day == currentDay.day);

      dayWidgets.add(
        SizedBox(
          width: 32,
          height: 32,
          child: GestureDetector(
            onTap: isWeekend ? null : () => _onDaySelected(currentDay),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      day.toString(),
                      style: AppTextStyle.bodyText.copyWith(
                        color: isSelected
                            ? Colors.white
                            : (isWeekend ? Colors.grey : Colors.black),
                      ),
                    ),
                  ),
                ),
                if (hasAvailableSlot || isFullyBooked)
                  Positioned(
                    bottom: 2,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hasAvailableSlot ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
              ],
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
    setState(() {
      _selectedDate = day;
    });
    widget.onDaySelected(day, day, day);
  }

  void _changeMonth(int delta) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + delta, 1);
    });
  }
}