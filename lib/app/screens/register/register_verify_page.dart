import 'dart:async'; // Import for Timer
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/register/bloc/register_bloc.dart';
import 'package:wg_app/app/screens/register/register_verify_success_page.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class RegisterVerifyPage extends StatefulWidget {
  const RegisterVerifyPage({super.key});

  @override
  State<RegisterVerifyPage> createState() => _RegisterVerifyPageState();
}

class _RegisterVerifyPageState extends State<RegisterVerifyPage> {
  Timer? _timer;
  Timer? _checkRequestTimer;

  int _secondsRemaining = 120; // 2 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
    _startCheckRequest();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _checkRequestTimer?.cancel();
    super.dispose();
  }

  void _startCheckRequest() {
    _checkRequestTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      BlocProvider.of<RegisterBloc>(context).add(RegisterCheckVerifyEmail());
    });
  }

  void _startTimer() {
    _secondsRemaining = 120;
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is RegisterVerifySuccess) {
            _timer?.cancel();
            _checkRequestTimer?.cancel();
            Future.microtask(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => RegisterVerifySuccessPage(),
                ),
              );
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Image.asset('assets/images/verify_email.png'),
              SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.confirm_your_email.tr(),
                style: AppTextStyle.heading1,
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.resend_in.tr(),
                        ),
                        Text(_formatTime(_secondsRemaining)),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                      onTap: () {
                        _startTimer();
                        BlocProvider.of<RegisterBloc>(context)
                          ..add(RegisterResendEmailVerification());
                      },
                      isDisabled: (_secondsRemaining != 0) ? true : false,
                      text: LocaleKeys.send_again.tr(),
                      textColor: Colors.black,
                      bgColor: AppColors.grayForText,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          LocaleKeys.change_email.tr(),
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
