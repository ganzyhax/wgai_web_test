import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/atlas/atlas_complete_screen.dart';
import 'package:wg_app/app/screens/atlas/bloc/atlas_bloc.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_info_start_page.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AtlasScreen extends StatelessWidget {
  const AtlasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size(60, 60),
          child: CustomAppbar(
              title: LocaleKeys.atlas_professions.tr(), withBackButton: true)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: BlocBuilder<AtlasBloc, AtlasState>(
          builder: (context, state) {
            if (state is AtlasLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AtlasLoaded) {
              return ListView.builder(
                itemCount: state.professions?.length,
                itemBuilder: (context, index) {
                  final profession = state.professions?[index];
                  final areaIconCode = profession?.areaIconCode ?? '';
                  final icon = myIconMap[areaIconCode];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: UniContainers(
                      title:
                          profession?.title?.getLocalizedString(context) ?? '',
                      icon: icon,
                      onTap: () {
                        if (profession != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AtlasCompleteScreen(
                                profession: profession,
                                professionsId: profession.code ?? '',
                              ),
                            ),
                          );
                        }
                      },
                      showIcon: icon != null,
                    ),
                  );
                },
              );
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
