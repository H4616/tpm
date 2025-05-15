import 'package:flutter/material.dart';
import 'package:tpm_tugas3/view/AboutPage.dart';
import 'package:tpm_tugas3/view/ListAnggotaPage.dart';
import 'package:tpm_tugas3/Service/LogoutService.dart';
import '../Service/StopwatchService.dart';
import 'package:tpm_tugas3/Service/JenisBilanganService.dart';
import '../Service/LocationService.dart';
import '../Service/KonversiService.dart';
import 'package:tpm_tugas3/view/WebViewPage.dart';
import '../Service/RecommendationService.dart';
import 'package:tpm_tugas3/view/MapPage.dart';

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
  late List<Map<String, dynamic>> _recommendedSites;
  final TimeConverter _konversiService = TimeConverter();
  final TextEditingController _controller = TextEditingController();

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
    _recommendedSites =
        _recommendationService
            .getRecommendedSites(); // Ambil daftar situs rekomendasi
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
      _numberType = _jenisBilangan.checkNumberType(
        _inputNumber,
      ); // Memanggil fungsi checkNumberType
    });
  }

  // Fungsi untuk mengonversi Tahun
  void _convertTime() {
    setState(() {
      _convertedTime = _konversiService.convertYears(
        double.tryParse(_yearsInput) ?? 0.0,
      ); // Mengonversi detik ke format waktu
    });
  }

  // Fungsi untuk toggle favorit
  void _toggleFavorite(int index) {
    setState(() {
      _recommendedSites[index]['isFavorite'] =
          !_recommendedSites[index]['isFavorite'];
    });
  }

  // Fungsi reset bilangan
  void _resetbilangan() {
    setState(() {
      _controller.clear(); // Menghapus teks yang ada pada TextField
      _numberType = ''; // Mengosongkan hasil jenis bilangan
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
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
                      controller:
                          _controller, // Menggunakan controller untuk mengelola input
                      keyboardType:
                          TextInputType
                              .number, // Mengatur keyboard untuk input angka
                      onChanged: (value) {
                        setState(() {
                          _inputNumber =
                              value; // Menyimpan input yang dimasukkan pengguna
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
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _checkNumberType,
                          child: const Text('Check Number Type'),
                        ),
                        const SizedBox(
                          width: 16,
                        ), // Jarak antara tombol check dan reset
                        ElevatedButton(
                          onPressed: _resetbilangan,
                          child: const Text('Reset'),
                        ),
                      ],
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
                      keyboardType:
                          TextInputType
                              .number, // Mengatur keyboard untuk input angka
                      onChanged: (value) {
                        setState(() {
                          _yearsInput =
                              value; // Menyimpan input tahun dari pengguna
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location: $_location',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Arahkan ke MapScreen ketika tombol ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapScreen()),
                        );
                      },
                      child: Text("Open Map"),
                    ),
                  ],
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
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Menampilkan daftar situs dengan gambar favicon dan tombol favorit
                    ..._recommendedSites.map((site) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Image.network(
                            site['favicon'], // Menampilkan favicon
                            width: 40,
                            height: 40,
                          ),
                          title: Text(site['name']),
                          subtitle: Text(site['url']),
                          trailing: IconButton(
                            icon: Icon(
                              site['isFavorite']
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  site['isFavorite'] ? Colors.red : Colors.grey,
                            ),
                            onPressed:
                                () => _toggleFavorite(
                                  _recommendedSites.indexOf(site),
                                ), // Toggle favorit
                          ),
                          onTap: () {
                            // Menavigasi ke situs web jika diklik
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => WebViewPage(url: site['url']),
                              ),
                            );
                          },
                        ),
                      );
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
