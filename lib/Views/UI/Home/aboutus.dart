import 'package:flutter/material.dart';

import '../../../Utils/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Anti ',
                      style: TextStyle(
                          fontSize: 16, color: AppColors.primaryColor)),
                  TextSpan(
                    text:
                        'is an app designed to help users track their food purchases, calories, and supplements.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app provides a platform for users to track their daily food intake, including calories, macronutrients, and other nutrients.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app also provides a platform for users to track their supplements and medications, including dosages, frequencies, and notes.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app is designed to be easy to use and provides a user-friendly interface for tracking and managing health data.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app is not affiliated with any medical or health-related organization and should not be used as a substitute for professional medical advice.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
