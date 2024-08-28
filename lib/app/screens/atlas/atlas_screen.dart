import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/atlas/bloc/atlas_bloc.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';

class AtlasScreen extends StatelessWidget {
  const AtlasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Профессии',
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        //        BlocBuilder<AtlasBloc, AtlasState>(
        //   builder: (context, state) {
        //     if (state is SpecialitiesLoaded) {

        //     } else {
        //       const CircularProgressIndicator();
        //     }
        //   },
        // )
      ),
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
                  final professions = state.professions?[index];
                  final areaIconCode = professions?.areaIconCode ?? '';
                  final icon = myIconMap[areaIconCode];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: UniContainers(
                      title: professions?.occupation ?? '',
                      icon: icon,
                      onTap: () {},
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
