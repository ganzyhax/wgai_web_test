import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_complete.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';

class SpecialitiesCompleteScreen extends StatefulWidget {
  final String speciesId;
  const SpecialitiesCompleteScreen({super.key, required this.speciesId});

  @override
  State<SpecialitiesCompleteScreen> createState() =>
      SpecialitiesCompleteScreenState();
}

class SpecialitiesCompleteScreenState
    extends State<SpecialitiesCompleteScreen> {
  late bool isBookmarked;

  @override
  void initState() {
    isBookmarked = false;
    super.initState();
  }

  void toggleBookmark() async {
    if (isBookmarked) {
      await BookmarkData().removeItem('bookmarks', widget.speciesId);
    } else {
      await BookmarkData().addItem(
          'bookmarks', {'id': widget.speciesId, 'data': widget.speciesId});
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('Специальность'.tr(),
            style: AppTextStyle.heading1.copyWith(
              color: AppColors.calendarTextColor,
            )),
        actions: [
          IconButton(
            onPressed: () {
              toggleBookmark();
              print('Id: ${widget.speciesId}');
            },
            icon: isBookmarked
                ? SvgPicture.asset('assets/icons/bookmark.svg')
                : SvgPicture.asset('assets/icons/bookmark-open.svg'),
          ),
        ],
      ),
      body: BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
        builder: (context, state) {
          if (state is SpecialitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SpecialitiesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UniComplete(
                    code: state.specialResources?[0].code ?? '',
                    title: state.specialResources?[0].name
                            ?.getLocalizedString(context) ??
                        '',
                    description: state
                            .specialResources?[0].profileSubjects?[0].name
                            ?.getLocalizedString(context) ??
                        '',
                    isUnivesity: false,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Гранты',
                    style: AppTextStyle.titleHeading
                        .copyWith(color: AppColors.calendarTextColor),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Общий конкурс',
                    style: AppTextStyle.bodyTextMiddle
                        .copyWith(color: AppColors.calendarTextColor),
                  ),
                ],
              ),
            );
          } else if (state is SpecialitiesError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
