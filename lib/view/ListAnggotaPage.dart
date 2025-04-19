import 'package:flutter/material.dart';

class ListAnggotaPage extends StatelessWidget {
   ListAnggotaPage({super.key});

  // Data dummy anggota
  final List<Map<String, String>> anggota = [
    {'name': 'Ahmad Hanif Habib Annafi', 'Nim': '123210147'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Anggota'),
      ),
      body: ListView.builder(
        itemCount: anggota.length,  // Menentukan jumlah item
        itemBuilder: (context, index) {
          final anggotaItem = anggota[index];

          return Card(
            elevation: 5, // Memberikan efek bayangan pada card
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Margin sekitar card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Membuat sudut card membulat
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anggotaItem['name']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Nim: ${anggotaItem['Nim']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
