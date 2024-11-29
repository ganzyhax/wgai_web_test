import 'dart:developer';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wg_app/app/screens/ai/bloc/ai_bloc.dart';
import 'package:wg_app/app/screens/atlas/bloc/atlas_bloc.dart';
import 'package:wg_app/app/screens/colleges/bloc/colleges_bloc.dart';
import 'package:wg_app/app/screens/community/bloc/community_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/app/screens/consultation_request/bloc/consultation_request_bloc.dart';
import 'package:wg_app/app/screens/ent/bloc/ent_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/countries/bloc/country_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/programs/bloc/programs_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/bloc/foreign_university_bloc.dart';
import 'package:wg_app/app/screens/forget_password/bloc/forget_password_bloc.dart';
import 'package:wg_app/app/screens/login/bloc/login_bloc.dart';
import 'package:wg_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/personal_growth/bloc/personal_bloc.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_career/bloc/profile_career_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_settings/pages/profile_change_email_and_pass/bloc/change_email_and_pass_bloc.dart';
import 'package:wg_app/app/screens/profile_growth/bloc/profile_growth_bloc.dart';
import 'package:wg_app/app/screens/psytest/bloc/test_bloc.dart';
import 'package:wg_app/app/screens/psytest/screens/description_test_screen.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
import 'package:wg_app/app/screens/register/bloc/register_bloc.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_choose_language_screen.dart';
import 'package:wg_app/app/screens/splash/splash_screen.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class WeGlobalApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
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
            create: (context) => QuestionnaireBloc(),
          ),
          BlocProvider(
            create: (context) => ConsultationRequestBloc(),
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
            create: (context) => AtlasBloc()..add(AtlasLoad()),
          ),
          BlocProvider(
            create: (context) => ProfileGrowthBloc()..add(ProfileGrowthLoad()),
          ),
          BlocProvider(
            create: (context) => ProfileCareerBloc()..add(ProfileCareerLoad()),
          ),
          BlocProvider(
            create: (context) => CountryBloc()..add(CountryLoad()),
          ),
          BlocProvider(
            create: (context) =>
                ForeignUniversityBloc()..add(ForeignUniversityLoad()),
          ),
          BlocProvider(
            create: (context) => ProgramsBloc()..add(ProgramsLoad()),
          ),
          BlocProvider(
            create: (context) => EntBloc()..add(EntLoad()),
          ),
          BlocProvider(
            create: (context) => AiBloc()..add(AiLoad()),
          ),
          BlocProvider(
            create: (context) =>
                ChangeEmailAndPassBloc()..add(ChangeEmailAndPassLoad()),
          ),
          BlocProvider(
            create: (context) =>
                ForgetPasswordBloc()..add(ForgetPasswordLoad()),
          ),
          BlocProvider(
            create: (context) => CollegesBloc()..add(CollegesLoad()),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          builder: (BuildContext context, Widget? child) {
            return (kIsWeb)
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: Container(
                          width: 400, // Fixed width for mobile-like experience
                          height: constraints.maxHeight, // Full height
                          child: MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              size: Size(400, constraints.maxHeight),
                              textScaleFactor:
                                  1.0, // Prevent text scaling issues
                            ),
                            child: child!,
                          ),
                        ),
                      );
                    },
                  )
                : MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      size: Size(375, MediaQuery.of(context).size.height),
                      textScaleFactor: 1.0,
                    ),
                    child: child!,
                  );
          },
          debugShowCheckedModeBanner: false,
          title: 'WeGlobal',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: SplashScreen(),
        ));
  }
}
