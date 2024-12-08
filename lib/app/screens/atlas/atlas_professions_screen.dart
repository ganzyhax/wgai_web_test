import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/atlas/atlas_complete_screen.dart';
import 'package:wg_app/app/screens/atlas/bloc/atlas_bloc.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AtlasProfessionsScreen extends StatelessWidget {
  final String clusterId;
  final String title;

  const AtlasProfessionsScreen({
    super.key,
    required this.clusterId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Dispatch the event to load professions for the clusterId
    context.read<AtlasBloc>()..add(AtlasLoadByClusterId(clusterId: clusterId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppbar(
          title: title,
          withBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<AtlasBloc, AtlasState>(
            builder: (context, state) {
              if (state is AtlasLoaded) {
                return (state.professions != null)
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.professions.length,
                        itemBuilder: (context, index) {
                          var profession = state.professions[index];

                          final areaIconCode = profession['areaIconCode'];
                          final icon = myIconMap[areaIconCode];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: UniContainers(
                              title: profession['title']
                                  [context.locale.languageCode],
                              icon: icon,
                              onTap: () {
                                if (profession != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AtlasCompleteScreen(
                                          profession: profession,
                                          professionsId: profession['code']),
                                    ),
                                  );
                                }
                              },
                              showIcon: icon != null,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
