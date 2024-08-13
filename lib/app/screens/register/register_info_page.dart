import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/register/bloc/register_bloc.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/app/widgets/textfields/phone_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';

class RegisterInfoPage extends StatefulWidget {
  const RegisterInfoPage({super.key});

  @override
  State<RegisterInfoPage> createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RegisterSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustomNavigationBar()),
                (Route<dynamic> route) => false);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is RegisterLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Center(
                      child: Text(
                        'Давайте знакомиться!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 26),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ваше имя',
                                style: TextStyle(color: AppColors.grayForText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  hintText: 'Ваше имя', controller: name),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Фамилия',
                                style: TextStyle(color: AppColors.grayForText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  hintText: 'Ваша фамилия',
                                  controller: surname),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Номер телефона',
                                style: TextStyle(color: AppColors.grayForText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 47,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            'assets/images/tel-kz-flag.png',
                                            width: 24,
                                          ),
                                          Text(
                                            '+7',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          const VerticalDivider(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: TextFieldInput(
                                        hintText: 'Номер телефона',
                                        textInputType: TextInputType.phone,
                                        textEditingController: phone,
                                        isPhoneInput: true,
                                        autoFocus: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              CustomButton(
                                text: 'Далее',
                                onTap: () {
                                  BlocProvider.of<RegisterBloc>(context)
                                    ..add(RegisterFillUserInfo(
                                        name: name.text,
                                        phone: phone.text,
                                        surname: surname.text));
                                },
                              ),
                            ]))
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
