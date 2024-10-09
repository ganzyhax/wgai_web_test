import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_info_start_page.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ForeignUnversityDetail extends StatelessWidget {
  final data;
  const ForeignUnversityDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child:
            CustomAppbar(title: "Университет", withBackButton: true),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/460672/pexels-photo-460672.jpeg?auto=compress&cs=tinysrgb&w=800'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        data['name'][context.locale.languageCode],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.country.tr(),
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppConstant.countriesCode[data['countryCode']]![
                          context.locale.languageCode]!,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.short_description.tr(),
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Html(
                        data: data['description'][context.locale.languageCode]),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.website.tr(),
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            final website = data["website"];
                            if (website != null && website.toString().isNotEmpty) {
                              _launchURL(website.toString());
                            }
                          },
                          child: Text(
                            data['website']?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Text(
                LocaleKeys.programs.tr(),
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                  itemCount: data['majors'].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['majors'][index]['name'],
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                data['majors'][index]['department'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}


Future<void> _launchURL(String urlString) async {
  final Uri? url = Uri.tryParse(urlString);
  if (url != null && await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $urlString';
  }
}
