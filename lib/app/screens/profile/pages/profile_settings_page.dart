import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_container.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController surname = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        centerTitle: false,
        titleSpacing: 16,
        title: Text(
          'Настройки',
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/profile-dummy.png'),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: CustomButton(
                  text: 'Изменить',
                  onTap: () {},
                  bgColor: Colors.grey[300],
                  textColor: Colors.black,
                  borderRadius: 35,
                  height: 40,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ваше имя',
                    style: TextStyle(color: AppColors.grayForText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(hintText: 'Ваше имя', controller: name),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ваше фамилия',
                    style: TextStyle(color: AppColors.grayForText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hintText: 'Ваша фамилия', controller: surname),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4.5,
                  ),
                  CustomButton(
                      text: 'Сохранить',
                      onTap: () {
                        BlocProvider.of<ProfileBloc>(context)
                          ..add(ProfileChangeUserData(
                              name: name.text, surname: surname.text));
                        Navigator.pop(context, true);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'Удалить аккаунт',
                    onTap: () {},
                    bgColor: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
