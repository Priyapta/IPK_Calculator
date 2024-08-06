import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Semi-Circular Progress Bar Example'),
        ),
        body: Center(
          child: SemiCircularProgressBar(
              progress: 0.75), // Adjust progress value here
        ),
      ),
    );
  }
}

class SemiCircularProgressBar extends StatelessWidget {
  final double progress;

  SemiCircularProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 100), // Size of the widget
      painter: SemiCircularProgressPainter(progress),
    );
  }
}

class SemiCircularProgressPainter extends CustomPainter {
  final double progress;

  SemiCircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0;

    Paint progressPaint = Paint()
      ..color = Color.fromARGB(255, 109, 187, 182)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;

    // Draw the background arc
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      -3.14, // Start angle in radians
      3.14, // Sweep angle in radians (half circle)
      false,
      backgroundPaint,
    );

    // Draw the progress arc
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      -3.14, // Start angle in radians
      3.14 * progress, // Sweep angle proportional to progress
      false,
      progressPaint,
    );

    // Draw the text in the center
    TextSpan span = new TextSpan(
      style: new TextStyle(
          color: Colors.blueGrey[300],
          fontSize: 20,
          fontWeight: FontWeight.bold),
      text: '${(progress * 4)}',
    );
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas,
        new Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
