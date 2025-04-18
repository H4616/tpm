import 'package:flutter/material.dart';

class ListAnggotaPage extends StatelessWidget {
  const ListAnggotaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Anggota'),
      ),
      body: const Center(
        child: Text('This is the List Anggota page'),
      ),
    );
  }
}