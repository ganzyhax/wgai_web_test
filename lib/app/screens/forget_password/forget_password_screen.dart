import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/forget_password/bloc/forget_password_bloc.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  int resetType = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
        builder: (context, state) {
          if (state is ForgetPasswordLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text('Forget Password'),
                    SizedBox(
                      height: 50,
                    ),
                    (state.type == 0)
                        ? CustomTextField(hintText: 'Email', controller: email)
                        : CustomTextField(hintText: 'Phone', controller: email),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              BlocProvider.of<ForgetPasswordBloc>(context)
                                ..add(ForgetPasswordChangeType());
                              email.text = '';
                              phone.text = '';
                            },
                            child: Text(
                              (state.type == 0)
                                  ? 'Reset by phone'
                                  : 'Reset by email',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomButton(text: 'Send OTP', onTap: () {})
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
    );
  }
}
