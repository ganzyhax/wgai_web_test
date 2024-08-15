import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/questionnaire/questionnaire_screen.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ResourcesScreen /screens/recources/resources_screen.dart'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QuestionnaireScreen()));
        },
      ),
    );
  }
}
