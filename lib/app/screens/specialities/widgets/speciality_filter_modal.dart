import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/specialities/model/kaz_specialities.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_info_start_page.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class SpecialityFilterModal extends StatefulWidget {
  final specialResources;
  final Function(String) onItemSelected; // Callback for returning selected data

  const SpecialityFilterModal(
      {super.key,
      required this.onItemSelected,
      required this.specialResources});

  @override
  _SpecialityFilterModalState createState() => _SpecialityFilterModalState();
}

class _SpecialityFilterModalState extends State<SpecialityFilterModal> {
  String? selectedItem; // Variable to store the selected item

  @override
  Widget build(BuildContext context) {
    log(widget.specialResources.toString());
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      height:
          MediaQuery.of(context).size.height / 1.3, // Adjust height as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close icon and title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Выбор Сферы',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'Пожалуйста выберите сферу профессии',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 16.0),
          // Scrollable buttons list
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget
                  .specialResources.length, // Change to your data list length
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedItem = widget.specialResources[index]['name']
                          [context.locale.languageCode]; // Select the item
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedItem ==
                                widget.specialResources[index]['name']
                                    [context.locale.languageCode]
                            ? AppColors.primary // Highlight selected item
                            : AppColors.background,
                      ),
                      child: Text(
                        widget.specialResources[index]['name']
                            [context.locale.languageCode],
                        style: TextStyle(
                          color: selectedItem ==
                                  widget.specialResources[index]['name']
                                      [context.locale.languageCode]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          // Bottom "Выбрать" button
          CustomButton(
            text: LocaleKeys.choose.tr(),
            onTap: () {
              if (selectedItem != null) {
                widget
                    .onItemSelected(selectedItem!); // Pass data back to parent
                Navigator.pop(context); // Close the modal
              }
            },
          )
        ],
      ),
    );
  }
}
