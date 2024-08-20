import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class TimeSlotWidget extends StatefulWidget {
  const TimeSlotWidget({super.key});

  @override
  State<TimeSlotWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  final List<String> _timeSlots = [];
  String? _selectedSlot;

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    DateTime startTime = DateTime(0, 1, 1, 9, 0);
    DateTime endTime = DateTime(0, 1, 1, 18, 0);
    Duration slotDuration = const Duration(minutes: 30);

    while (startTime.isBefore(endTime)) {
      final String slot =
          '${_formatTime(startTime)} - ${_formatTime(startTime.add(slotDuration))}';
      _timeSlots.add(slot);
      startTime = startTime.add(slotDuration);
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _toggleSlot(String slot) {
    setState(() {
      _selectedSlot = (_selectedSlot == slot) ? null : slot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _timeSlots.map((slot) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              slot,
              style: AppTextStyle.heading4
                  .copyWith(color: AppColors.calendarTextColor),
            ),
            trailing: GestureDetector(
              onTap: () => _toggleSlot(slot),
              child: SvgPicture.asset(
                _selectedSlot == slot
                    ? 'assets/icons/checkbox_fill.svg'
                    : 'assets/icons/checkbox_blank.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
