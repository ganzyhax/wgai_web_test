import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/login/bloc/login_bloc.dart';
import 'package:wg_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
import 'package:wg_app/app/screens/questionnaire/screens/description_questionnaire_screen.dart';
import 'package:wg_app/app/screens/register/bloc/register_bloc.dart';
import 'package:wg_app/app/screens/splash/splash_screen.dart';

class WeGlobalApp extends StatelessWidget {
  const WeGlobalApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final dashboardBloc = GetIt.instance<DashboardBloc>();
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
            create: (context) => QuestionnaireBloc()..add(LoadQuestions()),
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
