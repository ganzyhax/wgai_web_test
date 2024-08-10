import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/alert/custom_alert.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thumbnaik'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const CustomAlert(
                  title: 'Ваш запрос отправлен!',
                  description: 'Ждите подтверждения вашего профориентатора!',
                ),
              );
            },
            child: const Text('show dialog'),
          ),
        ],
      ),
    );
  }
}
