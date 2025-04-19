import 'package:flutter/material.dart';
import 'package:tpm_tugas3/LoginPage.dart';
import 'package:tpm_tugas3/HomePage.dart';
import 'package:tpm_tugas3/LoginService.dart'; 

void main() {
  runApp(const SmartApp());
}

class SmartApp extends StatelessWidget {
  const SmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart app',
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 217, 255, 0)),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: LoginService().checkLoginStatus(), // Cek status login
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data == true) {
            return const HomePage(); // Jika sudah login, arahkan ke HomePage
          } else {
            return const LoginPages(); // Jika belum login, tampilkan LoginPage
          }
        },
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginPages(),
        '/home': (BuildContext context) => const HomePage(),

      },
    );
  }
}
