import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/bloc/community_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/consultant_page.dart';
import 'package:wg_app/app/screens/community/pages/news/news_screen.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_choose_language_screen.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class CommunityScreen extends StatelessWidget {
  final bool? isCounsulant;
  final String? scrollId;
  const CommunityScreen({super.key, this.isCounsulant, this.scrollId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        if (state is CommunityLoaded) {
          if (!state.isOpened) {
            if (isCounsulant != null) {
              if (isCounsulant == false) {
                BlocProvider.of<CommunityBloc>(context)
                  ..add(CommunitySelectTabIndex(selectedTabIndex: 0));
              }
              if (isCounsulant == true) {
                BlocProvider.of<CommunityBloc>(context)
                  ..add(CommunitySelectTabIndex(selectedTabIndex: 1));
              }
              BlocProvider.of<CommunityBloc>(context)
                ..add(CommunitySetIsOpened());
            }
          }
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: AppColors.background,
              leading: (isCounsulant != null)
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        BlocProvider.of<CommunityBloc>(context)
                          ..add(CommunitySelectTabIndex(selectedTabIndex: 0));
                        BlocProvider.of<CommunityBloc>(context)
                          ..add(CommunitySetIsOpened());
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CustomNavigationBar()),
                            (Route<dynamic> route) => false);
                      })
                  : null,
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<CommunityBloc>(context)
                          ..add(CommunitySelectTabIndex(selectedTabIndex: 0));
                      },
                      child: Text(
                        LocaleKeys.feed.tr(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: (state.selectedTabIndex == 0)
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<CommunityBloc>(context)
                          ..add(CommunitySelectTabIndex(selectedTabIndex: 1));
                      },
                      child: Text(
                        LocaleKeys.consultant.tr(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: (state.selectedTabIndex == 1)
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: state.selectedTabIndex == 0
                ? (scrollId != null)
                    ? NewsScreen(
                        newsID: scrollId,
                      )
                    : NewsScreen()
                : const ConsultantPage(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
