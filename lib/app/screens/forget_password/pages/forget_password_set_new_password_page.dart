import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForgetPasswordSetNewPasswordPage extends StatefulWidget {
  const ForgetPasswordSetNewPasswordPage({super.key});

  @override
  State<ForgetPasswordSetNewPasswordPage> createState() =>
      _ForgetPasswordSetNewPasswordPageState();
}

class _ForgetPasswordSetNewPasswordPageState
    extends State<ForgetPasswordSetNewPasswordPage> {
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  bool showPass1 = true;
  bool showPass2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Center(
                child: Text(
                  LocaleKeys.create_new_password.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(LocaleKeys.create_new_password.tr()),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                  hintText: '********',
                  controller: pass1,
                  passwordShow: showPass1,
                  isPassword: true,
                  onTapIcon: () {
                    if (showPass1) {
                      setState(() {
                        showPass1 = false;
                      });
                    } else {
                      setState(() {
                        showPass1 = true;
                      });
                    }
                  }),
              SizedBox(
                height: 15,
              ),
              Text(LocaleKeys.repeat_new_password.tr()),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                hintText: '********',
                controller: pass2,
                passwordShow: showPass2,
                isPassword: true,
                onTapIcon: () {
                  if (showPass2) {
                    setState(() {
                      showPass2 = false;
                    });
                  } else {
                    setState(() {
                      showPass2 = true;
                    });
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                  text: LocaleKeys.change.tr(),
                  onTap: () {
                    if (pass1.text == pass2.text) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      CustomSnackbar().showCustomSnackbar(context,
                          LocaleKeys.password_are_not_match.tr(), false);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
