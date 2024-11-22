import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wg_app/app/screens/personal_growth/bloc/personal_bloc.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_card.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_test_card.dart';
import 'package:wg_app/app/widgets/webview/html_loader.dart';
import 'package:wg_app/app/widgets/webview/html_webview.dart';
import 'package:wg_app/app/screens/questionnaire/questionnaire_screen.dart';

import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

import 'package:wg_app/utils/fcm_service.dart';

class PersonalGrowthScreen extends StatefulWidget {
  const PersonalGrowthScreen({super.key});

  @override
  State<PersonalGrowthScreen> createState() => _PersonalGrowthScreenState();
}

class _PersonalGrowthScreenState extends State<PersonalGrowthScreen> {
  final FCMService _fcmService = FCMService();

  @override
  void initState() {
    super.initState();
    _fcmService.initializeAfterLogin(context);
    // Handle the case when the app is opened via a notification click
    _fcmService.handleInitialMessage(context);

    // Listen for notification taps when the app is in the background/foreground
    _fcmService.configureNotificationActions(context);
  }

  @override
  Widget build(BuildContext context) {
    var mainCategories = {
      'enlightenment': {
        "kk": "Өзіңді тану",
        "ru": "Самопознание",
        "en": "Enlightenment",
      },
      'job-market': {
        "kk": "Еңбек нарығы",
        "ru": "Рынок труда",
        "en": "Job Market",
      },
      'decision-making': {
        "kk": "Шешім қабылдау",
        "ru": "Принятие решений",
        "en": "Decision Making",
      },
      'apply-kaz': {
        "kk": "ҰБТға дайындық",
        "ru": "Подготовка к ЕНТ",
        "en": "Apply to KZ universities",
      },
      'apply-abroad': {
        "kk": "Шетелдік ЖОО-ға түсу",
        "ru": "Поступление в зарубежные ВУЗы",
        "en": "Apply abroad",
      },
      'apply-nu': {
        "kk": "Назарбаев Университетіне түсу",
        "ru": "Поступление в Назарбаев Университет",
        "en": "Apply to NU",
      }
    };
    Future<void> refreshPage() async {
      BlocProvider.of<PersonalBloc>(context).add(PersonalLoad());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: BlocBuilder<PersonalBloc, PersonalState>(
          builder: (context, state) {
            if (state is PersonalLoaded) {
              // Group data by taskCode
              var groupedData =
                  _groupDataByTaskCode(state.data, mainCategories);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          LocaleKeys.personal_growth.tr(),
                          style: AppTextStyle.heading1,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   LocaleKeys.personal_growth.tr(),
                            //   style: AppTextStyle.heading1,
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              LocaleKeys.personalGrowthDescription.tr(),
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 19),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      ...groupedData.entries.map((entry) {
                        var taskCode = entry.key;
                        var categoryData = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PersonalGrowthTestCard(
                              title: mainCategories[taskCode]
                                      ?[context.locale.languageCode] ??
                                  'Error',
                              asset: 'assets/icons/brain.svg',
                            ),
                            SizedBox(height: 10),
                            ...categoryData.map((item) {
                              return Column(
                                children: [
                                  PersonalGrowthCard(
                                      onTap: () async {
                                        if (item['availabilityStatus'] !=
                                                'locked' &&
                                            item['type'] == 'reading') {
                                          if (item['completionStatus'] ==
                                              'new') {
                                            var newstatus = "incomplete";
                                            if (item['completionQuiz'] ==
                                                    null ||
                                                item['completionQuiz'].length ==
                                                    0) {
                                              newstatus = "complete";
                                            }
                                            BlocProvider.of<PersonalBloc>(
                                                context)
                                              ..add(
                                                  PersonalGuidanceTaskUpdateStatus(
                                                      status: newstatus,
                                                      guidanceTaskId:
                                                          item['_id']));
                                            List<Map<String, dynamic>>
                                                quizData =
                                                (item['completionQuiz']
                                                        as List<dynamic>)
                                                    .cast<
                                                        Map<String, dynamic>>();
                                            final res = (!kIsWeb)
                                                ? await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => HtmlWebView(
                                                          contentCode: item[
                                                              'contentCode'],
                                                          isUrl: false,
                                                          contentUrl: item[
                                                              'contentCode'],
                                                          contentUrlTitle: "",
                                                          quizData: quizData,
                                                          completionStatus: item[
                                                              'completionStatus']),
                                                    ),
                                                  )
                                                : await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => HtmlLoader(
                                                          contentCode: item[
                                                              'contentCode'],
                                                          isUrl: false,
                                                          contentUrl: item[
                                                              'contentCode'],
                                                          contentUrlTitle: "",
                                                          quizData: quizData,
                                                          completionStatus: item[
                                                              'completionStatus']),
                                                    ));
                                            if (res != null && res) {
                                              BlocProvider.of<PersonalBloc>(
                                                  context)
                                                ..add(
                                                    PersonalGuidanceTaskUpdateStatus(
                                                        status: 'complete',
                                                        guidanceTaskId:
                                                            item['_id']));
                                            }
                                          }
                                          if (item['completionStatus'] ==
                                              'incomplete') {
                                            List<Map<String, dynamic>>
                                                quizData =
                                                (item['completionQuiz']
                                                        as List<dynamic>)
                                                    .cast<
                                                        Map<String, dynamic>>();

                                            final res = (!kIsWeb)
                                                ? await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => HtmlWebView(
                                                          contentCode: item[
                                                              'contentCode'],
                                                          isUrl: false,
                                                          contentUrl: item[
                                                              'contentCode'],
                                                          contentUrlTitle: "",
                                                          quizData: quizData,
                                                          completionStatus: item[
                                                              'completionStatus']),
                                                    ),
                                                  )
                                                : await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => HtmlLoader(
                                                          contentCode: item[
                                                              'contentCode'],
                                                          isUrl: false,
                                                          contentUrl: item[
                                                              'contentCode'],
                                                          contentUrlTitle: "",
                                                          quizData: quizData,
                                                          completionStatus: item[
                                                              'completionStatus']),
                                                    ),
                                                  );

                                            if (res != null && res) {
                                              BlocProvider.of<PersonalBloc>(
                                                  context)
                                                ..add(
                                                    PersonalGuidanceTaskUpdateStatus(
                                                        status: 'complete',
                                                        guidanceTaskId:
                                                            item['_id']));
                                            }
                                          }
                                          if (item['completionStatus'] ==
                                              'complete') {
                                            log(item.toString());
                                            (!kIsWeb)
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => HtmlWebView(
                                                          contentCode: item[
                                                              'contentCode'],
                                                          isUrl: false,
                                                          contentUrl: item[
                                                              'contentCode'],
                                                          contentUrlTitle: "",
                                                          completionStatus: item[
                                                              'completionStatus']),
                                                    ),
                                                  )
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => HtmlLoader(
                                                          contentCode: item[
                                                              'contentCode'],
                                                          isUrl: false,
                                                          contentUrl: item[
                                                              'contentCode'],
                                                          contentUrlTitle: "",
                                                          completionStatus: item[
                                                              'completionStatus']),
                                                    ),
                                                  );
                                          }
                                        } else if (item['availabilityStatus'] !=
                                                'locked' &&
                                            item['type'] == 'testing') {
                                          if (item['completionStatus'] ==
                                              'new') {
                                            BlocProvider.of<PersonalBloc>(
                                                context)
                                              ..add(
                                                  PersonalGuidanceTaskUpdateStatus(
                                                      status: 'incomplete',
                                                      guidanceTaskId:
                                                          item['_id']));
                                            final res = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    QuestionnaireScreen(
                                                  testingCode:
                                                      item['testingCode'],
                                                  taskId: item['_id'],
                                                  isGuidanceTask: true,
                                                ),
                                              ),
                                            );
                                            if (res != null && res) {
                                              // BlocProvider.of<PersonalBloc>(
                                              //     context)
                                              //   ..add(
                                              //       PersonalGuidanceTaskUpdateStatus(
                                              //           status: 'complete',
                                              //           guidanceTaskId:
                                              //               item['_id']));
                                              BlocProvider.of<PersonalBloc>(
                                                      context)
                                                  .add(
                                                      PersonalCheckGuidanceTask(
                                                          guidanceTaskId:
                                                              item['_id']));
                                            }
                                          }
                                          if (item['completionStatus'] ==
                                              'incomplete') {
                                            final res = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    QuestionnaireScreen(
                                                  testingCode:
                                                      item['testingCode'],
                                                  taskId: item['_id'],
                                                  isGuidanceTask: true,
                                                ),
                                              ),
                                            );
                                            if (res != null && res) {
                                              // BlocProvider.of<PersonalBloc>(
                                              //     context)
                                              //   ..add(
                                              //       PersonalGuidanceTaskUpdateStatus(
                                              //           status: 'complete',
                                              //           guidanceTaskId:
                                              //               item['_id']));
                                              BlocProvider.of<PersonalBloc>(
                                                      context)
                                                  .add(
                                                      PersonalCheckGuidanceTask(
                                                          guidanceTaskId:
                                                              item['_id']));
                                            }
                                          }
                                          if (item['completionStatus'] ==
                                              'complete') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    QuestionnaireScreen(
                                                  testingCode:
                                                      item['testingCode'],
                                                  taskId: item['_id'],
                                                  isGuidanceTask: true,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      subTitle: item['subtitle']
                                          [context.locale.languageCode],
                                      type: (item['availabilityStatus'] ==
                                              'locked')
                                          ? 3
                                          : (item['completionStatus'] ==
                                                      'new' ||
                                                  item['completionStatus'] ==
                                                      'incomplete')
                                              ? 2
                                              : 1,
                                      isFinished: (item['availabilityStatus'] !=
                                                  'locked' &&
                                              item['completionStatus'] ==
                                                  'complete')
                                          ? true
                                          : false,
                                      title: item['title']
                                          [context.locale.languageCode],
                                      interpretationLink:
                                          (item.containsKey('result')
                                              ? item['result'].containsKey(
                                                      'interpretationLink')
                                                  ? item['result']
                                                      ['interpretationLink']
                                                  : null
                                              : null),
                                      isTesting: item['type'] == 'testing'),
                                  SizedBox(height: 20),
                                ],
                              );
                            }).toList(),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupDataByTaskCode(
      List<dynamic> data, Map<String, Map<String, String>> mainCategories) {
    var groupedData = <String, List<Map<String, dynamic>>>{};

    for (var item in data) {
      var taskCode = item['taskCode'];
      var category = mainCategories.keys
          .firstWhere((key) => taskCode.startsWith(key), orElse: () => '');

      if (category != '') {
        if (!groupedData.containsKey(category)) {
          groupedData[category] = [];
        }
        groupedData[category]!.add(item);
      }
    }

    return groupedData;
  }
}
