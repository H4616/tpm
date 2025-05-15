class TimeConverter {
  // Fungsi untuk mengonversi tahun ke bulan, hari, jam, menit, detik
  String convertYears(double years) {
    // Memeriksa apakah nilai tahun lebih besar dari batas maksimum untuk int

    // Menghitung bulan, hari, jam, menit, detik berdasarkan tahun
    double totalDays = years * 365.25;  // Menghitung total hari berdasarkan tahun (365.25 untuk memperhitungkan tahun kabisat)
    int months = (years * 12).toInt(); // 1 tahun = 12 bulan
    int days = totalDays.toInt(); // Menghitung hari
    double remainingDays = totalDays - days; // Menghitung sisa hari dari pecahan tahun
    int hours = (remainingDays * 24).toInt(); // Mengonversi sisa hari ke jam
    int minutes = (hours * 60).toInt(); // Mengonversi jam ke menit
    int seconds = (minutes * 60).toInt(); // Mengonversi menit ke detik

    return '$years Tahun, $months Bulan, $days Hari, $hours Jam, $minutes Menit, $seconds Detik';
  }

  // Fungsi untuk mengonversi tahun, bulan, hari, jam, menit, detik ke total detik
  int convertToSeconds({int years = 0, int months = 0, int days = 0, int hours = 0, int minutes = 0, int seconds = 0}) {
    // Memeriksa apakah nilai total detik melebihi batas maksimum untuk int
    int totalSeconds = 0;
    
    // Mengonversi tahun ke detik (365.25 hari per tahun)
    totalSeconds += (years * 365.25 * 24 * 60 * 60).toInt();
    // Mengonversi bulan ke detik (30.4375 hari per bulan)
    totalSeconds += (months * 30.4375 * 24 * 60 * 60).toInt();
    // Mengonversi hari ke detik
    totalSeconds += (days * 24 * 60 * 60).toInt();
    // Mengonversi jam ke detik
    totalSeconds += (hours * 60 * 60).toInt();
    // Mengonversi menit ke detik
    totalSeconds += (minutes * 60).toInt();
    // Menambahkan detik
    totalSeconds += seconds;

    // Jika total detik melebihi batas maksimal int, kembalikan pesan error
    if (totalSeconds < 0) {
      throw Exception('Total detik melebihi batas maksimum untuk tipe data int');
    }

    return totalSeconds;
  }
}
