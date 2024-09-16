import 'package:flutter/material.dart';

class UniversityKzTypeCard extends StatelessWidget {
  final String type;
  final String universityName;
  final String universityCode;
  const UniversityKzTypeCard(
      {super.key,
      required this.type,
      required this.universityCode,
      required this.universityName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (type == 'dream')
              ? Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.grey,
                    ),
                    Text('Dream Choice')
                  ],
                )
              : (type == 'target')
                  ? Row(
                      children: [
                        Icon(
                          Icons.cabin,
                          color: Colors.grey,
                        ),
                        Text('Target Choice')
                      ],
                    )
                  : Row(
                      children: [
                        Icon(
                          Icons.safety_check,
                          color: Colors.grey,
                        ),
                        Text('Safe Choice')
                      ],
                    ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(universityName)),
                Icon(Icons.edit)
              ],
            ),
          )
        ],
      ),
    );
  }
}
