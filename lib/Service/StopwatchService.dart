import 'dart:async';

class StopwatchService {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _time = '00:00:00';
  final void Function(String) onTimeUpdate;

  StopwatchService({required this.onTimeUpdate});

  String get time => _time;

  void _updateTime() {
    final seconds = _stopwatch.elapsed.inSeconds;
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60; 
    
    // Mengatur jam agar tidak lebih dari 23
    // hours = hours % 24;

    _time = '${hours.toString().padLeft(2, '0')}:'
        '${(minutes % 60).toString().padLeft(2, '0')}:'
        '${(seconds % 60).toString().padLeft(2, '0')}';

    onTimeUpdate(_time); // Trigger update ke UI
  }

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateTime());
    }
  }

  void stop() {
    _stopwatch.stop();
    _timer?.cancel();
    _updateTime();
  }

  void reset() {
    _stopwatch.reset();
    _updateTime();
  }

  void dispose() {
    _timer?.cancel();
  }
}
