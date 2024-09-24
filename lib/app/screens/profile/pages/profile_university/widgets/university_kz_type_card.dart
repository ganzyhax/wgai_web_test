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
                            Text('Target Choice 2')
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
              crossAxisAlignment: CrossAxisAlignment.start,  // Align items to the top
              children: [
                Expanded(  // Use Expanded to allow the Column to take up available space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,  // Align text to the left
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          widget.universityName,
                          style: TextStyle(fontWeight: FontWeight.bold),  // Optional: make the university name bold
                        ),
                      ),
                      // the variable name mySpeciality is actually profile subject need to fix
                      // specialty name should be under the university name
                      // SizedBox(height: 8),  // Add some vertical spacing between the text widgets
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width / 1.5,
                      //   child: Text(
                      //     widget.mySpeciality,  // Assuming this is the text you want to display
                      //     style: TextStyle(fontSize: 14),  // Optional: make the speciality text slightly smaller
                      //   ),
                      // ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialitiesScreen(
                          specialityName: widget.mySpeciality,
                        ),
                      ),
                    );

                    setState(() {});
                  },
                  child: Icon(Icons.edit),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
