import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/atlas/bloc/atlas_bloc.dart';
import 'package:wg_app/app/screens/atlas/model/professions_model.dart';
import 'package:wg_app/app/screens/atlas/widgets/atlas_container.dart';
import 'package:wg_app/app/screens/atlas/widgets/atlas_title_container.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/app/widgets/containers/basic_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AtlasCompleteScreen extends StatefulWidget {
  final Professions profession;
  final String professionsId;

  const AtlasCompleteScreen(
      {super.key, required this.profession, required this.professionsId});

  @override
  State<AtlasCompleteScreen> createState() => _AtlasCompleteScreenState();
}

class _AtlasCompleteScreenState extends State<AtlasCompleteScreen> {
  late bool isBookmarked;

  @override
  void initState() {
    isBookmarked = BookmarkData()
        .containsItem(AppHiveConstants.professions, widget.professionsId);
    super.initState();
  }

  void toggleBookmark() async {
    if (isBookmarked) {
      BlocProvider.of<ProfileBloc>(context)
        ..add(ProfileDeleteMyCareerBookmark(
            occupationCode: widget.professionsId));
    } else {
      BlocProvider.of<ProfileBloc>(context).add(ProfileAddMyCareerBookmark(
          occupationCode: widget.professionsId,
          title: widget.profession.title!.toJson(),
          areaIconCode: widget.profession.areaIconCode!));
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: LocaleKeys.professions.tr(),
          withBackButton: true,
          actions: [
            IconButton(
              onPressed: () {
                toggleBookmark();
                print('Id: ${widget.professionsId}');
              },
              icon: isBookmarked
                  ? SvgPicture.asset('assets/icons/bookmark.svg')
                  : SvgPicture.asset('assets/icons/bookmark-open.svg'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {},
          child: BlocBuilder<AtlasBloc, AtlasState>(
            builder: (context, state) {
              if (state is AtlasLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AtlasLoaded) {
                return ListView(
                  children: _buildContainers(context, widget.profession),
                );
              } else if (state is SpecialitiesError) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContainers(BuildContext context, Professions profession) {
    List<Widget> containers = [];

    containers.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: AtlasTitleContainer(
          icon: profession.areaIconCode ?? '',
          title: profession.title?.getLocalizedString(context) ?? '',
          titleDescription: LocaleKeys.short_description.tr(),
          description: profession.description?.getLocalizedString(context) ??
              'No description',
        ),
      ),
    );

    if (profession.sections != null && profession.sections!.isNotEmpty) {
      for (var i = 0; i < profession.sections!.length; i++) {
        final section = profession.sections![i];
        containers.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AtlasContainer(
              index: i + 1,
              title: section.title?.getLocalizedString(context) ?? '',
              description: section.content?.getLocalizedString(context) ?? '',
            ),
          ),
        );
      }
    }

    if (profession.gops != null && profession.gops!.isNotEmpty) {
      for (var gop in profession.gops!) {
        containers.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: UniContainers(
              codeNumber: gop.code ?? '',
              title: gop.name?.getLocalizedString(context) ?? '',
              onTap: () {},
            ),
          ),
        );
      }
    }

    if (profession.summary != null) {
      containers.add(
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BasicContainer(
            text: profession.summary?.getLocalizedString(context) ?? '',
          ),
        ),
      );
    }

    return containers;
  }
}
