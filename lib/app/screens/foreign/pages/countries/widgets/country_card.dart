import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryCard extends StatelessWidget {
  final String text;
  final String icon;
  const CountryCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.network(
            'https://flagcdn.com/' + icon + '.svg',
            width: 35,
            height: 35,
          ),
          SizedBox(
            height: 5,
          ),
          Text(text)
        ],
      ),
    );
  }
}
