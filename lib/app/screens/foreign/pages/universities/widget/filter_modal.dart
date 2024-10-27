import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/widget/foreign_university_fee_slider.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheet({Key? key, required this.onApplyFilters})
      : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  var feeValues = [0, 100000];
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

          // Fee slider
          TuitionFeeSlider(
            onFeeChanged: (val) {
              feeValues = val;
              setState(() {});
            },
          ),

          const SizedBox(height: 16),

          // Apply button
          CustomButton(
              text: LocaleKeys.apply.tr(),
              onTap: () {
                Map<String, dynamic> filters = {
                  'countryCode': selectedCountryCode,
                  'feeValues': feeValues
                };
                widget.onApplyFilters(filters);
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
