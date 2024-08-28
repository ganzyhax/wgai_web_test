import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wg_app/app/screens/atlas/bloc/atlas_bloc.dart';
import 'package:wg_app/app/screens/community/bloc/community_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/app/screens/consulation_request/bloc/consulation_request_bloc.dart';
import 'package:wg_app/app/screens/login/bloc/login_bloc.dart';
import 'package:wg_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/personal_growth/bloc/personal_bloc.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/psytest/bloc/test_bloc.dart';
import 'package:wg_app/app/screens/psytest/screens/description_test_screen.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
import 'package:wg_app/app/screens/register/bloc/register_bloc.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/splash/splash_screen.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';

class WeGlobalApp extends StatelessWidget {
  const WeGlobalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainNavigatorBloc()..add(MainNavigatorLoad()),
          ),
          BlocProvider(
            create: (context) => RegisterBloc()..add(RegisterLoad()),
          ),
          BlocProvider(
            create: (context) => LoginBloc()..add(LoginLoad()),
          ),
          BlocProvider(
            create: (context) => TestBloc()..add(LoadQuestions()),
          ),
          BlocProvider(
            create: (context) => CommunityBloc()..add(CommunityLoad()),
          ),
          BlocProvider(
            create: (context) => NewsBloc()..add(NewsLoad()),
          ),
          BlocProvider(
            create: (context) => ConsultantBloc()..add(ConsultantLoad()),
          ),
          BlocProvider(
            create: (context) => QuestionnaireBloc()..add(LoadQuestionnaire()),
          ),
          BlocProvider(
            create: (context) =>
                ConsulationRequestBloc()..add(ConsulationLoad()),
          ),
          BlocProvider(
            create: (context) => UniversitiesBloc()..add(LoadUniversities()),
          ),
          BlocProvider(
            create: (context) => PersonalBloc()..add(PersonalLoad()),
          ),
          BlocProvider(
            create: (context) => SpecialitiesBloc()..add(LoadSpecialities()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc()..add(ProfileLoad()),
          ),
          BlocProvider(
            create: (context) => AtlasBloc()..add(LoadAtlas()),
          ),
        ],
        child: MaterialApp(
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'WeGlobal',
          home: SplashScreen(),
        ));
  }
}
