// instructions_page.dart
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Center(
                child: const Text(
                  'How to Use the App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Langkah 1: Login
              _buildStep('1. Login', 'First, log in using your credentials to access the app features.'),
              const SizedBox(height: 16),

              // Langkah 2: Navigate to Home
              _buildStep('2. Navigate to Home', 'After logging in, you will be directed to the Home page, where you can access various app features.'),
              const SizedBox(height: 16),

              // Langkah 3: Stopwatch Feature
              _buildStep('3. Stopwatch Feature', 'Use the stopwatch feature to track time. You can start, stop, and reset the timer as needed.'),
              const SizedBox(height: 16),

              // Langkah 4: Number Type Checker
              _buildStep('4. Number Type Checker', 'Enter a number to check if it is even or odd. Press "Reset" to clear the input.'),
              const SizedBox(height: 16),

              // Langkah 5: Convert Time
              _buildStep('5. Convert Time', 'Use the Time Converter to convert years to seconds and view the result.'),
              const SizedBox(height: 16),

              // Langkah 6: Location Feature
              _buildStep('6. Location Feature', 'The app will fetch your current location and display it on the screen. You can also navigate to the map.'),
              const SizedBox(height: 16),

              // Langkah 7: Recommended Sites
              _buildStep('7. Recommended Sites', 'View a list of recommended websites. You can mark your favorites and visit the sites directly from the app.'),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan setiap langkah
  Widget _buildStep(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bullet point
        const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 24,
        ),
        const SizedBox(width: 8),
        // Deskripsi langkah
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
