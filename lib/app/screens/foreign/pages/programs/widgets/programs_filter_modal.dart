import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ProgramsFilterModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const ProgramsFilterModal({Key? key, required this.onApplyFilters})
      : super(key: key);

  @override
  _ProgramsFilterModalState createState() => _ProgramsFilterModalState();
}

class _ProgramsFilterModalState extends State<ProgramsFilterModal> {
  String? selectedCountryCode; // Holds the selected country code

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.filter.tr(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Dropdown for selecting the country
          DropdownButtonFormField<String>(
            value: selectedCountryCode,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: LocaleKeys.country.tr(),
                focusColor: Colors.grey[400],
                fillColor: Colors.grey[400],
                hoverColor: Colors.grey[400]),
            items: AppConstant.countriesCode.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value[context.locale.languageCode] ?? ''),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCountryCode = value;
              });
            },
          ),

          const SizedBox(height: 16),

          // Apply button
          CustomButton(
              text: LocaleKeys.apply.tr(),
              onTap: () {
                Map<String, dynamic> filters = {
                  'countryCode': selectedCountryCode,
                };
                widget.onApplyFilters(filters);
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
