import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';

class TuitionFeeSlider extends StatefulWidget {
  final ValueChanged<List<int>> onFeeChanged;
  const TuitionFeeSlider({Key? key, required this.onFeeChanged})
      : super(key: key);

  @override
  _TuitionFeeSliderState createState() => _TuitionFeeSliderState();
}

class _TuitionFeeSliderState extends State<TuitionFeeSlider> {
  RangeValues _currentRangeValues = RangeValues(0, 999999);
  TextEditingController _minController = TextEditingController(text: "0");
  TextEditingController _maxController = TextEditingController(text: "999999");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tuition fee (USD)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 999999,
            divisions: 1000,
            activeColor: AppColors.primary,
            inactiveColor: Colors.grey.shade300,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                _minController.text = values.start.round().toString();
                _maxController.text = values.end.round().toString();

                widget.onFeeChanged([values.start.round(), values.end.round()]);
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Minimum value input field
              Expanded(
                child: TextField(
                  controller: _minController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.grey[400],
                      fillColor: Colors.grey[400],
                      hoverColor: Colors.grey[400]),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    double min =
                        double.tryParse(value) ?? _currentRangeValues.start;
                    setState(() {
                      _currentRangeValues = RangeValues(
                        min,
                        _currentRangeValues.end,
                      );
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              // Maximum value input field
              Expanded(
                child: TextField(
                  controller: _maxController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    double max =
                        double.tryParse(value) ?? _currentRangeValues.end;
                    setState(() {
                      _currentRangeValues = RangeValues(
                        _currentRangeValues.start,
                        max,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
