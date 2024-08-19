import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/components/consultant_card.dart';
import 'package:wg_app/app/screens/consulation_request/consulation_request_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';

class ConsultantPage extends StatelessWidget {
  const ConsultantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultantBloc, ConsultantState>(
      builder: (context, state) {
        if (state is ConsultantLoaded) {
          return Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                CustomButton(
                    text: 'Записаться на консультацию',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.0)),
                        ),
                        builder: (BuildContext context) {
                          return FractionallySizedBox(
                            heightFactor: 0.93,
                            child: ConsulationRequestScreen(),
                          );
                        },
                      );
                    }),
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.counselorData.length,
                    itemBuilder: (context, index) {
                      final counselor = state.counselorData[index];
                      return ConsultantCard(
                          data: counselor, localLang: state.localLang);
                    })
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
