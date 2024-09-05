import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/filter_bottom_sheet.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'ВУЗ-ы',
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ВУЗ-ы',
                  style: AppTextStyle.titleHeading
                      .copyWith(color: AppColors.blackForText),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const FilterBottomSheet();
                      },
                    );
                  },
                  icon: SvgPicture.asset('assets/icons/filter.svg'),
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<UniversitiesBloc, UniversitiesState>(
                builder: (context, state) {
                  if (state is UniversitiesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UniversitiesLoaded) {
                    return ListView.builder(
                      itemCount: state.universities?.length,
                      itemBuilder: (context, index) {
                        final university = state.universities?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: UniContainers(
                            codeNumber: university?.code ?? '',
                            title:
                                university?.name?.getLocalizedString(context) ??
                                    '',
                            firstDescription: university?.regionName
                                    ?.getLocalizedString(context) ??
                                '',
                            secondDescription:
                                university?.specialties?.length ?? 0,
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  } else if (state is UniversitiesError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
