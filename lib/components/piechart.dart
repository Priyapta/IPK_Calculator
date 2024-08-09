import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPie extends StatefulWidget {
  final List<double> values;

  const CustomPie({super.key, required this.values});

  @override
  State<CustomPie> createState() => _CustomPieState();
}

class _CustomPieState extends State<CustomPie> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6.0, // Adjust the aspect ratio as needed
      child: Container(
        margin: EdgeInsets.all(10),
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent e, PieTouchResponse? r) {
                setState(() {
                  if (!e.isInterestedForInteractions ||
                      r == null ||
                      r.touchedSection == null) {
                    _touchedIndex = -1;
                  } else {
                    _touchedIndex = r.touchedSection!.touchedSectionIndex;
                  }
                });
              },
            ),
            sections: widget.values.asMap().entries.map((entry) {
              int index = entry.key;
              double value = entry.value;

              return PieChartSectionData(
                radius: _touchedIndex == index
                    ? 80
                    : 50, // Highlight touched section
                borderSide: _touchedIndex == index
                    ? BorderSide(
                        width: 4,
                        color: Colors
                            .black) // Apply black border to touched section
                    : BorderSide(
                        width: 0,
                        color:
                            Colors.transparent), // No border when not touched
                value: value,
                color:
                    Colors.blueAccent, // Replace with your desired color logic
                title: 'smt ${value.toStringAsFixed(1)}',
              );
            }).toList(),
            centerSpaceRadius: 40,
          ),
        ),
      ),
    );
  }
}
