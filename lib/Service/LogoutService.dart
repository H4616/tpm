import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  // Menangani logout, menghapus status login
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
}
