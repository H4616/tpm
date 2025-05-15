import 'package:flutter/widgets.dart';

class Jenisbilangan{
    // Fungsi untuk memeriksa apakah angka tersebut bilangan prima
  bool isPrime(int number) {
    if (number <= 1) {
      return false; // Bilangan kurang dari atau sama dengan 1 bukan prima
    }
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        return false; // Jika angka dapat dibagi oleh angka lain selain 1 dan dirinya sendiri
      }
    }
    return true; // Bilangan prima
  }

  String checkJenisbilangan(num number) {
    String result = '';

    // Cek apakah angka adalah bilangan cacah
    if (number is int && number >= 0) {
      result += 'Cacah'; 
    }

    // Cek apakah angka adalah bilangan desimal
    if (number is double) {
      result += ' Desimal'; 
    }

    // Cek apakah angka genap atau ganjil
    if (number is int) {
      if (number % 2 == 0) {
        result += ' Genap';
      } else {
        result += ' Ganjil';
      }

      // Cek apakah angka adalah bilangan prima
      if (isPrime(number)) {
        result += ' Prima';
      }
    }

    // Cek apakah angka negatif
    if (number < 0) {
      result += ' Negatif';
    } else if (number > 0) {
      result += ' Positif';
    }

    // Menampilkan hasil
    return result.isNotEmpty ? result : 'Invalid Input';
  }

  // Fungsi untuk menangani input dari pengguna dan memeriksa jenis bilangan
  String checkNumberType(String input) {
    final number = int.tryParse(input); // Mengubah input menjadi integer
    if (number != null) {
      return checkJenisbilangan(number); 
    } else {
      return 'Invalid Input'; 
    }
  }

}

