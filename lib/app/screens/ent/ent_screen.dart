import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/ent/bloc/ent_bloc.dart';
import 'package:wg_app/app/widgets/webview/html_webview_html.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class EntScreen extends StatelessWidget {
  const EntScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.background,
          centerTitle: false,
          titleSpacing: 16,
          title: Text(
            LocaleKeys.resources.tr(),
            style: AppTextStyle.titleHeading
                .copyWith(color: AppColors.blackForText),
          )),
      body: SingleChildScrollView(
        child: BlocBuilder<EntBloc, EntState>(
          builder: (context, state) {
            if (state is EntLoaded) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://i.ibb.co.com/DL7rt9P/Rectangle-130.png')))),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text(
                      LocaleKeys.ent.tr(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.modules.tr(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.data['data']['untContent'].length,
                        itemBuilder: (context, index) {
                          var section = state.data['data']['untContent'][index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: ExpansionTile(
                                title: Text(
                                    section['title']
                                        [context.locale.languageCode],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                leading: Icon(Icons.book),
                                children: List.generate(
                                  section['subModules'].length,
                                  (subIndex) {
                                    var subModule =
                                        section['subModules'][subIndex];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AppColors.background),
                                        child: ListTile(
                                          trailing:
                                              Icon(Icons.keyboard_arrow_right),
                                          title: Text(
                                            subModule['title']
                                                [context.locale.languageCode],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    WebViewHtml(
                                                  content: subModule['content'][
                                                      context
                                                          .locale.languageCode],
                                                  contentTitle:
                                                      subModule['title'][context
                                                          .locale.languageCode],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          );
                        })
                  ],
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
}
