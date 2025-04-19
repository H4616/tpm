import 'package:flutter/material.dart';
import '../Service/StopwatchService.dart';

class StopwatchSection extends StatelessWidget {
  final StopwatchService stopwatchService;

  const StopwatchSection(this.stopwatchService);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stopwatch: ${stopwatchService.time}',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: stopwatchService.start,
              child: const Text('Start'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: stopwatchService.stop,
              child: const Text('Stop'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: stopwatchService.reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}
