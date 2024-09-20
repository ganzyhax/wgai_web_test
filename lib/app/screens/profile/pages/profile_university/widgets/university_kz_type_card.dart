import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/specialities/specialities_screen.dart';

class UniversityKzTypeCard extends StatefulWidget {
  final String type;
  final String universityName;
  final String universityCode;
  final String mySpeciality;
  const UniversityKzTypeCard(
      {super.key,
      required this.type,
      required this.universityCode,
      required this.mySpeciality,
      required this.universityName});

  @override
  State<UniversityKzTypeCard> createState() => _UniversityKzTypeCardState();
}

class _UniversityKzTypeCardState extends State<UniversityKzTypeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (widget.type == 'dreamChoice')
              ? Row(
                  children: [
                    SvgPicture.asset('assets/icons/dream_choice.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Dream Choice')
                  ],
                )
              : (widget.type == 'targetChoice1')
                  ? Row(
                      children: [
                        SvgPicture.asset('assets/icons/target_choice.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Target Choice 1')
                      ],
                    )
                  : (widget.type == 'targetChoice2')
                      ? Row(
                          children: [
                            SvgPicture.asset('assets/icons/target_choice.svg'),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Target2 Choice')
                          ],
                        )
                      : Row(
                          children: [
                            SvgPicture.asset('assets/icons/safe_choice.svg'),
                            SizedBox(
                              width: 5,
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
                    child: Text(widget.universityName)),
                GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpecialitiesScreen(
                                  specialityName: widget.mySpeciality,
                                )),
                      );

                      setState(() {});
                    },
                    child: Icon(Icons.edit))
              ],
            ),
          )
        ],
      ),
    );
  }
}
