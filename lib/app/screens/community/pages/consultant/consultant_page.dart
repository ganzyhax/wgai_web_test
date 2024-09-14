import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/components/consultant_card.dart';
import 'package:wg_app/app/screens/consultation_request/consultation_request_screen.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_choose_language_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ConsultantPage extends StatelessWidget {
  const ConsultantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultantBloc, ConsultantState>(
      builder: (context, state) {
        if (state is ConsultantLoaded) {
          return Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                CustomButton(
                    text: LocaleKeys.sign_up_consultation.tr(),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                        ),
                        builder: (BuildContext context) {
                          return const FractionallySizedBox(
                            heightFactor: 0.93,
                            child: ConsultationRequestScreen(),
                          );
                        },
                      );
                    }),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.counselorData.length,
                    itemBuilder: (context, index) {
                      final counselor = state.counselorData[index];
                      return ConsultantCard(data: counselor, localLang: state.localLang);
                    })
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
