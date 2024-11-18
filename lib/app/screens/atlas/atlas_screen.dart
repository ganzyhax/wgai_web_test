import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/atlas/atlas_complete_screen.dart';
import 'package:wg_app/app/screens/atlas/atlas_professions_screen.dart';
import 'package:wg_app/app/screens/atlas/bloc/atlas_bloc.dart';
import 'package:wg_app/app/screens/atlas/widgets/cluster_container.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AtlasScreen extends StatelessWidget {
  const AtlasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppbar(
            title: LocaleKeys.professions.tr(),
            withBackButton: true,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: BlocBuilder<AtlasBloc, AtlasState>(
          builder: (context, state) {
            if (state is AtlasLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AtlasLoaded) {
              return ListView.builder(
                  itemCount: state.clusters.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final areaIconCode = state.clusters[index]['areaIconCode'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                      value:
                                          BlocProvider.of<AtlasBloc>(context),
                                      child: AtlasProfessionsScreen(
                                        title: state.clusters[index]['name']
                                            [context.locale.languageCode],
                                        clusterId: state.clusters[index]
                                            ['code'],
                                      ))));
                        },
                        child: ClusterContainer(
                            icon: areaIconCode,
                            title: state.clusters[index]['name']
                                [context.locale.languageCode]),
                      ),
                    );
                  });

              // return ListView.builder(
              //   itemCount: state.professions?.length,
              //   itemBuilder: (context, index) {
              //     final profession = state.professions?[index];

              // final areaIconCode = profession?.areaIconCode ?? '';
              //     final icon = myIconMap[areaIconCode];
              //     return Padding(
              //       padding: const EdgeInsets.only(bottom: 8),
              //       child: UniContainers(
              //         firstDescription:
              //             profession?.cluster!.getLocalizedString(context),
              //         title:
              //             profession?.title?.getLocalizedString(context) ?? '',
              //         icon: icon,
              //         onTap: () {
              //           if (profession != null) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => AtlasCompleteScreen(
              //                   profession: profession,
              //                   professionsId: profession.code ?? '',
              //                 ),
              //               ),
              //             );
              //           }
              //         },
              //         showIcon: icon != null,
              //       ),
              //     );
              //   },
              // );
            } else if (state is SpecialitiesError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
