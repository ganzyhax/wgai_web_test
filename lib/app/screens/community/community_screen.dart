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

class CommunityScreen extends StatefulWidget {
  final bool? isCounsulant;
  final String? scrollId;
  const CommunityScreen({super.key, this.isCounsulant, this.scrollId});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state is CommunityLoaded) {
          _pageController.jumpToPage(state.selectedTabIndex);
        }
      },
      child: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          if (state is CommunityLoaded) {
            if (!state.isOpened) {
              if (widget.isCounsulant != null) {
                if (widget.isCounsulant == false) {
                  BlocProvider.of<CommunityBloc>(context)
                    ..add(CommunitySelectTabIndex(selectedTabIndex: 0));
                }
                if (widget.isCounsulant == true) {
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
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<CommunityBloc>(context)
                            ..add(CommunitySelectTabIndex(selectedTabIndex: 0));
                          _pageController.animateToPage(0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
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
                          _pageController.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
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
              body: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  BlocProvider.of<CommunityBloc>(context)
                    ..add(CommunitySelectTabIndex(selectedTabIndex: index));
                },
                children: [
                  (widget.scrollId != null)
                      ? NewsScreen(newsID: widget.scrollId)
                      : NewsScreen(),
                  const ConsultantPage(),
                ],
              ),
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
