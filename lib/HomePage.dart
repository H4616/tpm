import 'package:flutter/material.dart';
import 'package:tpm_tugas3/About.dart';
import 'package:tpm_tugas3/ListAnggota.dart';
import 'package:tpm_tugas3/LogoutService.dart';
import 'StopwatchService.dart';
import 'package:tpm_tugas3/JenisBilanganService.dart'; // Ensure this file defines the JenisBilangan class
import 'LocationService.dart';
import 'RecommendationService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Default to 'Home' page

  // Membuat instance dari semua service
  late StopwatchService _stopwatchService = StopwatchService(
    onTimeUpdate: (newTime) {
      setState(() {
        _stopwatchTime = newTime;
      });
    },
  );
  final Jenisbilangan _jenisBilangan = Jenisbilangan();
  final LocationService _locationService = LocationService();
  final RecommendationService _recommendationService = RecommendationService();

  String _location = "Fetching location..."; // Lokasi perangkat
  String _numberType = ''; // Menyimpan hasil penentuan jenis bilangan
  String _stopwatchTime = '00:00:00';

  // Halaman-halaman yang dapat dipilih dari bottom navigation bar
  final List<Widget> _pages = [
    const AboutPage(), // Halaman About
    const Center(
      child: Text('Home Page'),
    ), // Halaman Home (akan diubah dengan fitur)
    ListAnggotaPage(), // Halaman ListAnggota
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
    Navigator.pushReplacementNamed(
      context,
      '/login',
    ); // Navigasi kembali ke LoginPage
  }

  @override
  void initState() {
    super.initState();
    _stopwatchService = StopwatchService(
      onTimeUpdate: (newTime) {
        setState(() {
          _stopwatchTime = newTime;
        });
      },
    );

    _getLocation(); // Ambil lokasi saat halaman pertama kali dimuat
    _numberType = _jenisBilangan.checkJenisbilangan(
      5,
    ); // Misal kita periksa jenis bilangan untuk 5
  }

  @override
  void dispose() {
    _stopwatchService.dispose(); // stop timer
    super.dispose();
  }

  // Ambil lokasi perangkat
  void _getLocation() async {
    var locationData = await _locationService.getLocation();
    setState(() {
      _location =
          locationData != null
              ? 'Lat: ${locationData.latitude}, Long: ${locationData.longitude}'
              : 'Failed to get location';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed:
                () => _logout(context), // Menggunakan tombol logout di AppBar
          ),
        ],
      ),
      body:
          _selectedIndex == 1
              ? _buildHomePage() // Halaman Home dengan fitur
              : _pages[_selectedIndex], // Menampilkan halaman lain berdasarkan BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green, // Warna hijau untuk background
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
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

  // Membuat tampilan HomePage dengan fitur-fitur
  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fitur Stopwatch
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stopwatch: $_stopwatchTime',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _stopwatchService.start,
                      child: const Text('Start'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _stopwatchService.stop,
                      child: const Text('Stop'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _stopwatchService.reset,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Fitur Penampil Jenis Bilangan
            Text(
              'Number Type (5): $_numberType',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

            // Fitur Tracking LBS (Lokasi)
            Text('Location: $_location', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),

            // Fitur Daftar Situs Rekomendasi
            const Text('Recommended Sites:', style: TextStyle(fontSize: 20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  _recommendationService.getRecommendedSites().map((site) {
                    return Text(site, style: TextStyle(fontSize: 16));
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
