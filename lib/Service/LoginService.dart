import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  // Menyimpan status login
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // Memeriksa status login
  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    return isLoggedIn ?? false;
  }

  // Menangani login (username dan password)
  Future<bool> login(String username, String password) async {
    if (username == "flutter" && password == "flutter123") {
      await saveLoginStatus(true); // Menyimpan status login
      return true;
    }
    return false;
  }

  // Logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
}
