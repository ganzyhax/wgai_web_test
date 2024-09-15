import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/consultation_request/bloc/consultation_request_bloc.dart';
import 'package:wg_app/app/screens/consultation_request/widgets/custom_calendar.dart';
import 'package:wg_app/app/screens/consultation_request/widgets/time_slot_widget.dart';
import 'package:wg_app/app/screens/consultation_request/model/slot_model.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ConsultationRequestScreen extends StatefulWidget {
  const ConsultationRequestScreen({super.key});

  @override
  State<ConsultationRequestScreen> createState() => _ConsultationRequestScreenState();
}

class _ConsultationRequestScreenState extends State<ConsultationRequestScreen> {

  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchSlots();
  }

  void _fetchSlots() {
    final now = DateTime.now();
    final twoMonthsLater = now.add(const Duration(days: 60));
    context.read<ConsultationRequestBloc>().add(FetchSlots(now, twoMonthsLater));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultationRequestBloc, ConsultationRequestState>(
      listener: (context, state) {
        // if (state is ConsultationRequestSubmitted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(state.message)),
        //   );
        //   Navigator.of(context).pop(); // Or navigate to a confirmation screen
        // } else if (state is ConsultationRequestError) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(state.message)),
        //   );
        // }
        if (state is ConsultationRequestSubmitted) {
          _showResultAlert(context, state.message, true);
        } else if (state is ConsultationRequestError) {
          _showResultAlert(context, state.message, false);
        }
      },
      builder: (context, state) {
        if (state is ConsultationRequestInitial || state is ConsultationRequestLoading) {
          return _buildLoading();
        } else if (state is ConsultationRequestLoaded) {
          return _buildContent(state.slots);
        } else {
          return _buildError();
        }
      },
    );
  }

Widget _buildContent(List<SlotModel> slots) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
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
          CustomCalendar(
            onDaySelected: (selectedDay, _, __) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            language: context.locale.languageCode,
          ),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.select_slot.tr(),
            style: AppTextStyle.heading2.copyWith(color: AppColors.alternativeBlack),
          ),
          const SizedBox(height: 16),
          TimeSlotWidget(slots: slots, selectedDay: _selectedDay),
          const SizedBox(height: 24),
          CustomButton(
            text: LocaleKeys.sign_up_consultation.tr(),
            onTap: () {
              final selectedSlot = slots.firstWhere((slot) => slot.isSelected, orElse: () => slots.first);
              context.read<ConsultationRequestBloc>().add(SubmitConsultationRequest(selectedSlot.id));
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}


  void _showResultAlert(BuildContext context, String message, bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? "✅" : "😢"),
          content: Text(isSuccess ? LocaleKeys.consultationBookingSuccess.tr() : LocaleKeys.consultationBookingError.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the bottom sheet
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.error_loading_slots.tr()),
          ElevatedButton(
            onPressed: _fetchSlots,
            child: Text(LocaleKeys.try_again.tr()),
          ),
        ],
      ),
    );
  }
}
