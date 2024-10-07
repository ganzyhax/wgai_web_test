import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/screens/psytest/screens/description_test_screen.dart';
import 'package:wg_app/app/screens/psytest/screens/results_screen.dart';
import 'package:wg_app/app/screens/psytest/screens/test_screen.dart';
import 'package:wg_app/app/screens/questionnaire/questionnaire_screen.dart';
import 'package:wg_app/app/utils/helper_functions.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/webview/html_webview.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AppointmentCard extends StatelessWidget {
  final String slotDate;
  final String counselorName;

  const AppointmentCard({
    Key? key,
    required this.slotDate,
    required this.counselorName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.parse(slotDate).toLocal();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0, // Remove shadow
      color: Colors.white, // Set background color explicitly
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.youGotAppointment.tr(),
              style: TextStyle(color: Colors.grey[1200], fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              counselorName,
              style: TextStyle(color: Colors.grey[1200], fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '${LocaleKeys.consultationTime.tr()}: ${_formatDateTime(dateTime)}',
              style: TextStyle(color: Colors.grey[600], fontSize: 14)
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('HH:mm');
    return '${dateFormatter.format(dateTime)} ${timeFormatter.format(dateTime)}';
  }
}