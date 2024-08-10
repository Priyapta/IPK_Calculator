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
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth; // Adjust size based on the width

        return AspectRatio(
          aspectRatio: 5,
          child: Container(
            margin: EdgeInsets.all(10),
            width: size /
                2, // Set the width and height based on the calculated size
            height: size / 2,
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
                    radius: _touchedIndex == index ? 80 : 60,
                    borderSide: _touchedIndex == index
                        ? BorderSide(width: 3, color: Colors.black)
                        : BorderSide(width: 0, color: Colors.transparent),
                    value: value,
                    color: _touchedIndex == index
                        ? Colors.redAccent
                        : Colors.blueAccent,
                    title: 'smt ${value.toStringAsFixed(1)}',
                    titleStyle: TextStyle(
                      fontSize: _touchedIndex == index ? 20 : 16,
                      fontWeight: _touchedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  );
                }).toList(),
                centerSpaceRadius:
                    50, // Adjust center space radius based on size
              ),
            ),
          ),
        );
      },
    );
  }
}
