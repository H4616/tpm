import 'package:flutter/material.dart';
import 'package:tpm_tugas3/LoginService.dart'; // Mengimpor LoginService

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  String username = '';
  String password = '';
  bool _isPasswordVisible = false; //  toggle password visibility
  final LoginService _loginService = LoginService(); // Membuat instance dari LoginService

  void _login() async {
    bool isSuccess = await _loginService.login(username, password);
    if (isSuccess) {
      // Navigasi ke halaman home jika login berhasil
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Menampilkan SnackBar jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login GAGAL, Username / Password Salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
        return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50], // Latar belakang biru muda
        appBar: AppBar(
          centerTitle: true,
          title: Text("Smart App"),
          titleTextStyle: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          backgroundColor: const Color(0xFFFFEB3B),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40, // Ukuran tinggi gambar
              width: 40, // Ukuran lebar gambar
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                SizedBox(height: 30),
                _usernameField(),
                SizedBox(height: 20),
                _passwordField(),
                SizedBox(height: 30),
                _loginButton(context),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: Image.asset("assets/upn.png"),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      onChanged: (value) {
        username = value;
      },
      decoration: InputDecoration(
        hintText: "Username",
        prefixIcon: Icon(Icons.person, color: Colors.green),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  // Password field dengan toggle untuk melihat atau menyembunyikan password
  Widget _passwordField() {
    return TextFormField(
      onChanged: (value) {
        password = value;
      },
      obscureText: !_isPasswordVisible, // Jika _isPasswordVisible true, password terlihat
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: Icon(Icons.lock, color: Colors.green),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off, // Ikon toggle
            color: Colors.green,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // Toggle status password
            });
          },
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(              
            onPressed: _login,
              child: const Text('Login'),
            );
  }
}