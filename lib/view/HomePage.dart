import 'package:flutter/material.dart';
import 'package:tpm_tugas3/view/AboutPage.dart';
import 'package:tpm_tugas3/view/ListAnggotaPage.dart';
import 'package:tpm_tugas3/Service/LogoutService.dart';
import '../Service/StopwatchService.dart';
import 'package:tpm_tugas3/Service/JenisBilanganService.dart';
import '../Service/LocationService.dart';
import '../Service/RecommendationService.dart';
import '../Service/KonversiService.dart';

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
  final TimeConverter _konversiService = TimeConverter();

  String _location = "Fetching location..."; // Lokasi perangkat
  String _numberType = ''; // Menyimpan hasil penentuan jenis bilangan
  String _inputNumber = ''; // Menyimpan input angka dari pengguna
  String _stopwatchTime = '00:00:00';

  // Konversi waktu
  String _convertedTime = ''; // Menyimpan hasil konversi waktu
  String _yearsInput = ''; // Menyimpan input Tahun

  // Halaman-halaman yang dapat dipilih dari bottom navigation bar
  final List<Widget> _pages = [
    const AboutPage(), // Halaman About
    const Center(child: Text('Home Page')), // Halaman Home
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
    Navigator.pushReplacementNamed(context, '/login'); // Navigasi kembali ke LoginPage
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
  }

  @override
  void dispose() {
    _stopwatchService.dispose(); // Stop timer
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

  // Fungsi untuk memeriksa jenis bilangan
  void _checkNumberType() {
    setState(() {
      _numberType = _jenisBilangan.checkNumberType(_inputNumber); // Memanggil fungsi checkNumberType
    });
  }

  // Fungsi untuk mengonversi Tahun
  void _convertTime() {
    setState(() {
      _convertedTime = _konversiService.convertYears(double.tryParse(_yearsInput) ?? 0.0); // Mengonversi detik ke format waktu
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
            onPressed: () => _logout(context),
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: _selectedIndex == 1
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
        onTap: _onItemTapped,
        iconSize: 25,
        selectedFontSize: 18,
        unselectedFontSize: 12,
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fitur Stopwatch dalam Card
            Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stopwatch: $_stopwatchTime',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _stopwatchService.start,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Start'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _stopwatchService.stop,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Stop'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _stopwatchService.reset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Fitur Jenis Bilangan dalam Card
            Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input Field untuk angka
                    TextField(
                      keyboardType: TextInputType.number, // Mengatur keyboard untuk input angka
                      onChanged: (value) {
                        setState(() {
                          _inputNumber = value; // Menyimpan input yang dimasukkan pengguna
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter a number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol untuk mengecek jenis bilangan
                    ElevatedButton(
                      onPressed: _checkNumberType,
                      child: const Text('Check Number Type'),
                    ),

                    // Menampilkan jenis bilangan
                    Text(
                      'Number Type: $_numberType', // Menampilkan hasil jenis bilangan (Even/Odd)
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            // Fitur Konversi Waktu dalam Card
            Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input Field 
                    TextField(
                      keyboardType: TextInputType.number, // Mengatur keyboard untuk input angka
                      onChanged: (value) {
                        setState(() {
                          _yearsInput = value; // Menyimpan input tahun dari pengguna
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Years',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol untuk mengonversi detik
                    ElevatedButton(
                      onPressed: _convertTime,
                      child: const Text('Convert Time'),
                    ),

                    // Menampilkan hasil konversi waktu
                    Text(
                      'Converted Time: $_convertedTime', // Menampilkan hasil konversi waktu
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            // Fitur Lokasi dalam Card
            Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Location: $_location',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Fitur Daftar Situs Rekomendasi dalam Card
            Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recommended Sites:',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    ..._recommendationService.getRecommendedSites().map((site) {
                      return Text(site, style: TextStyle(fontSize: 18));
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
