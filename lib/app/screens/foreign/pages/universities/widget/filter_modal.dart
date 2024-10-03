import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheet({Key? key, required this.onApplyFilters})
      : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _countryCodeController = TextEditingController();

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
      child: Wrap(
        children: [
          Text(
            'Filter Universities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _countryCodeController,
            decoration: InputDecoration(
              labelText: 'Country Code',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Pass the filter values back to the screen
              Map<String, dynamic> filters = {
                'countryCode': _countryCodeController.text.isNotEmpty
                    ? _countryCodeController.text
                    : null,
              };
              widget.onApplyFilters(filters);
              Navigator.pop(context);
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    super.dispose();
  }
}