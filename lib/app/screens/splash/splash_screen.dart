import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/profile/pages/profile_settings/pages/profile_change_email_and_pass/profile_settings_change_password_screen.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_choose_language_screen.dart';
import 'package:wg_app/app/utils/amplitude.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;
  bool isFirstTime = false;
  bool requiresUpdate = false;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    await _checkForUpdate();

    // If an update is required, skip the navigation code
    if (requiresUpdate) return;

    isLogged = await LocalUtils.isLogged();
    isFirstTime = await LocalUtils.isFirstTime();

    Future.delayed(Duration(seconds: 2), () async {
      if (!requiresUpdate) {
        if (isLogged) {
          var login = await LocalUtils.getLogin();
          var pass = await LocalUtils.getPassword();
          // if (login.toString() == pass.toString()) {
          //   log(login + pass);
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ProfileSettingsChangePasswordScreen()),
          //   );
          // } else {
          String userId = await LocalUtils.getUserId();
          AmplitudeFunc().setUserProperties({'userId': userId});
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CustomNavigationBar()),
            (Route<dynamic> route) => false,
          );
          // }
        } else {
          if (isFirstTime) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => SplashChooseLanguagePage()),
              (Route<dynamic> route) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
            );
          }
        }
      }
    });
  }

  Future<void> _checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final response = await http.get(
          Uri.parse('https://v2.api.weglobal.ai/api/app/version'),
          headers: {
            'appPlatform': (Platform.isAndroid) ? 'android' : 'ios',
            'appVersion': currentVersion
          });
      if (response.statusCode == 200) {
        final versionInfo = jsonDecode(response.body);
        final latestVersion = versionInfo['latestVersion'];
        final forceUpdate = versionInfo['forceUpdate'];

        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;

        if (_isNewerVersion(currentVersion, latestVersion) && forceUpdate) {
          requiresUpdate = true;
          _showForceUpdateDialog();
        }
      }
    } catch (e) {
      print("Error checking for updates: $e");
    }
  }

  bool _isNewerVersion(String currentVersion, String latestVersion) {
    final currentParts = currentVersion.split('.').map(int.parse).toList();
    final latestParts = latestVersion.split('.').map(int.parse).toList();
    for (int i = 0; i < latestParts.length; i++) {
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }
    return false;
  }

  void _showForceUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.updateRequiredTitle.tr()),
          content: Text(LocaleKeys.updateRequiredMessage.tr()),
          actions: [
            TextButton(
              onPressed: () async {
                final Uri appStoreUrl =
                    Uri.parse('https://apps.apple.com/app/id6670311689');
                final Uri playStoreUrl = Uri.parse(
                    'https://play.google.com/store/apps/details?id=ai.weglobal.mobile');

                final Uri url = Platform.isIOS ? appStoreUrl : playStoreUrl;

                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(LocaleKeys.updateNow.tr()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.9,
              ),
              Image.asset('assets/images/splash_image.png'),
              SizedBox(
                height: 25,
              ),
              Text(
                'WEGLOBAL.AI',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  LocaleKeys.splash_subtitle.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
