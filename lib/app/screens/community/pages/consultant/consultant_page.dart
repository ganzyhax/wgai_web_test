import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/components/consultant_card.dart';
import 'package:wg_app/app/screens/consultation_request/consultation_request_screen.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_choose_language_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ConsultantPage extends StatefulWidget {
  const ConsultantPage({super.key});

  @override
  _ConsultantPageState createState() => _ConsultantPageState();
}

class _ConsultantPageState extends State<ConsultantPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload data every time the page is navigated to
    _loadConsultants();
  }

  // Method to load or refresh consultant data
  Future<void> _loadConsultants() async {
    BlocProvider.of<ConsultantBloc>(context).add(ConsultantLoad());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadConsultants, // Pull-to-refresh functionality
      child: BlocBuilder<ConsultantBloc, ConsultantState>(
        builder: (context, state) {
          if (state is ConsultantLoaded) {
            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                CustomButton(
                    text: LocaleKeys.sign_up_consultation.tr(),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.0)),
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
                    return ConsultantCard(
                        data: counselor, localLang: state.localLang);
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
