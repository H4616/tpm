import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendationService {
  // Daftar situs rekomendasi dengan data tambahan (nama, url, favicon)
  List<Map<String, dynamic>> _sites = [
    {
      'name': 'Google',
      'url': 'https://www.google.com',
      'favicon': 'https://www.google.com/favicon.ico',
      'isFavorite': false,
    },
    {
      'name': 'Stack Overflow',
      'url': 'https://www.stackoverflow.com',
      'favicon': 'https://www.stackoverflow.com/favicon.ico',
      'isFavorite': false,
    },
    {
      'name': 'GitHub',
      'url': 'https://www.github.com',
      'favicon': 'https://github.githubassets.com/favicon.ico',
      'isFavorite': false,
    },
  ];

  // Mengambil status favorit yang disimpan
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _sites.length; i++) {
      // Ambil nilai isFavorite dari SharedPreferences
      _sites[i]['isFavorite'] = prefs.getBool('favorite_$i') ?? false;
    }
  }

  // Menyimpan status favorit ke SharedPreferences
  Future<void> toggleFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    bool currentFavorite = _sites[index]['isFavorite'];
    
    // Toggle status favorit
    _sites[index]['isFavorite'] = !currentFavorite;
    
    // Simpan status favorit ke SharedPreferences
    await prefs.setBool('favorite_$index', _sites[index]['isFavorite']);
  }

  List<Map<String, dynamic>> getRecommendedSites() {
    return _sites;
  }
}
