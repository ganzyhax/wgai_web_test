import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/bloc/community_bloc.dart';
import 'package:wg_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:wg_app/app/screens/navigator/components/navigator_item.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainNavigatorBloc, MainNavigatorState>(
      listener: (context, state) {
        if (state is MainNavigatorLoaded) {
          BlocProvider.of<CommunityBloc>(context)
              .add(CommunitySelectTabIndex(selectedTabIndex: 0));
        }
      },
      child: BlocBuilder<MainNavigatorBloc, MainNavigatorState>(
        builder: (context, state) {
          if (state is MainNavigatorLoaded) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.background,
              body: Column(
                children: [
                  Expanded(child: state.screens[state.index]),
                  Container(
                    height: 80,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.whiteForText,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     BlocProvider.of<MainNavigatorBloc>(context)
                        //         .add(MainNavigatorChangePage(index: 0));
                        //   },
                        //   child: NavigationItem(
                        //     assetImage: 'assets/icons/consultant.svg',
                        //     isSelected: (state.index == 0) ? true : false,
                        //   ),
                        // ),
                        InkWell(
                          onTap: () async {
                            await LocalUtils.setLanguage(
                                context.locale.languageCode);
                            BlocProvider.of<MainNavigatorBloc>(context)
                                .add(MainNavigatorChangePage(index: 0));
                          },
                          child: NavigationItem(
                            assetImage: 'assets/icons/route.svg',
                            isSelected: (state.index == 0) ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await LocalUtils.setLanguage(
                                context.locale.languageCode);
                            BlocProvider.of<MainNavigatorBloc>(context)
                                .add(MainNavigatorChangePage(index: 1));
                          },
                          child: NavigationItem(
                            assetImage: 'assets/icons/comunity.svg',
                            isSelected: (state.index == 1) ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await LocalUtils.setLanguage(
                                context.locale.languageCode);
                            BlocProvider.of<MainNavigatorBloc>(context)
                                .add(MainNavigatorChangePage(index: 2));
                          },
                          child: NavigationItem(
                            assetImage: 'assets/icons/books.svg',
                            isSelected: (state.index == 2) ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await LocalUtils.setLanguage(
                                context.locale.languageCode);
                            BlocProvider.of<MainNavigatorBloc>(context)
                                .add(MainNavigatorChangePage(index: 3));
                          },
                          child: NavigationItem(
                            assetImage: 'assets/icons/profile.svg',
                            isSelected: (state.index == 3) ? true : false,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
