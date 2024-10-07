import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/ent/bloc/ent_bloc.dart';
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
            LocaleKeys.ent.tr(),
            style: AppTextStyle.titleHeading
                .copyWith(color: AppColors.blackForText),
          )),
      body: SingleChildScrollView(
        child: BlocBuilder<EntBloc, EntState>(
          builder: (context, state) {
            return Column(
              children: [],
            );
          },
        ),
      ),
    );
  }
}
