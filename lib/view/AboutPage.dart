import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deskripsi Aplikasi
            const Text(
              'Smart App is a productivity tool designed to help you manage tasks efficiently. This app provides features for task management, time tracking, and more.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // Informasi Pengembang
            const Text(
              'Developed by: Andalan Group',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are passionate about building simple and effective solutions to make your daily tasks easier.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Versi Aplikasi
            const Text(
              'App Version: 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Kontak atau Media Sosial
            const Text(
              'Contact Us:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: andalanGroupTech@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Website: www.AndalanGroupTech.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Copyright
            const Text(
              '© 2025 Andalan Group Tech. All Rights Reserved.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
