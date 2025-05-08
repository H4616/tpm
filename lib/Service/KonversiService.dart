class TimeConverter {
  // Fungsi untuk mengonversi tahun ke bulan, hari, jam, menit, dan detik
  String convertYears(int years) {
    int months = years * 12; // 1 tahun = 12 bulan
    int days = years * 365; // Menghitung hari dengan asumsi 1 tahun = 365 hari
    int hours = days * 24; // Menghitung jam dari hari
    int minutes = hours * 60; // Menghitung menit dari jam
    int seconds = minutes * 60; // Menghitung detik dari menit

    return '$years Tahun, $months Bulan, $days Hari, $hours Jam, $minutes Menit, $seconds Detik';
  }

  // Fungsi untuk mengonversi tahun, bulan, hari, jam, menit, detik ke total detik
  int convertToSeconds({int years = 0, int months = 0, int days = 0, int hours = 0, int minutes = 0, int seconds = 0}) {
    int totalSeconds = 0;

    totalSeconds += years * 365 * 24 * 60 * 60; // Tahun ke detik (dengan asumsi 1 tahun = 365 hari)
    totalSeconds += months * 30 * 24 * 60 * 60; // Bulan ke detik (dengan asumsi 1 bulan = 30 hari)
    totalSeconds += days * 24 * 60 * 60; // Hari ke detik
    totalSeconds += hours * 60 * 60; // Jam ke detik
    totalSeconds += minutes * 60; // Menit ke detik
    totalSeconds += seconds; // Detik

    return totalSeconds;
  }
}
