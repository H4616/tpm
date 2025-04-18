import 'package:flutter/material.dart';
import 'package:tpm_tugas3/About.dart';
import 'package:tpm_tugas3/ListAnggota.dart'; // Mengimpor halaman ListAnggota
import 'package:tpm_tugas3/LogoutService.dart'; // Mengimpor LogoutService

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Menyimpan halaman yang dipilih

  // Halaman-halaman yang dapat dipilih dari bottom navigation bar
  final List<Widget> _pages = [
    const Center(child: Text('Home Page')), // Halaman Home
    const AboutPage(), // Halaman About
    const ListAnggotaPage(), // Halaman ListAnggota
  ];

  // Fungsi untuk mengubah halaman saat item bottom navigation dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk logout
  void _logout(BuildContext context) async {
    LogoutService logoutService = LogoutService();
    await logoutService.logout(); // Menghapus status login
    Navigator.pushReplacementNamed(context, '/login'); // Navigasi kembali ke LoginPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context), // Menggunakan tombol logout di AppBar
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman yang sesuai berdasarkan index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green, // Warna hijau untuk background
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped, // Fungsi yang dipanggil saat tab dipilih

        iconSize: 25, // Ukuran ikon
        selectedFontSize: 18, // Ukuran font teks yang dipilih
        unselectedFontSize: 12, // Ukuran font teks yang tidak dipilih
      ),
    );
  }
}
