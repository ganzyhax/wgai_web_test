import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/bloc/community_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/consultant_page.dart';
import 'package:wg_app/app/screens/community/pages/news/news_screen.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        if (state is CommunityLoaded) {
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
                      },
                      child: Text(
                        'Feed',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: (state.selectedTabIndex == 0)
                                ? Colors.black
                                : Colors.grey[400]),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<CommunityBloc>(context)
                          ..add(CommunitySelectTabIndex(selectedTabIndex: 1));
                      },
                      child: Text(
                        'Consultant',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: (state.selectedTabIndex == 1)
                                ? Colors.black
                                : Colors.grey[400]),
                      ),
                    ),
                  ],
                )),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    (state.selectedTabIndex == 0)
                        ? NewsScreen()
                        : ConsultantPage()
                  ],
                ),
              ));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
