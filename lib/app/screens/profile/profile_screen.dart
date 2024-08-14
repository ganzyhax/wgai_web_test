import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/psytest/screens/description_test_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile Screen /screens/profile/profile_screen.dart'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DescriptionTestScreen()),
          );
        },
      ),
    );
  }
}
