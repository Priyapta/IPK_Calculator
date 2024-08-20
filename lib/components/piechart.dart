import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPie extends StatefulWidget {
  final Map<String, double> value;

  const CustomPie({super.key, required this.value});

  @override
  State<CustomPie> createState() => _CustomPieState();
}

class _CustomPieState extends State<CustomPie> {
  late List<String> keys;
  int _touchedIndex = -1;
  late List<double> values;

  @override
  void initState() {
    super.initState();
    values = widget.value.values.toList();
    keys = widget.value.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth;

        return AspectRatio(
          aspectRatio: 5,
          child: Container(
            margin: EdgeInsets.all(10),
            width: size / 4,
            height: size / 4,
            child: values.isNotEmpty
                ? PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent e, PieTouchResponse? r) {
                          setState(() {
                            if (!e.isInterestedForInteractions ||
                                r == null ||
                                r.touchedSection == null) {
                              _touchedIndex = -1;
                            } else {
                              _touchedIndex =
                                  r.touchedSection!.touchedSectionIndex;
                            }
                          });
                        },
                      ),
                      sections: values.asMap().entries.map((entry) {
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
                              : const Color.fromARGB(255, 216, 187, 187),
                          title:
                              'smt ${keys[index]}\n(${value.toStringAsFixed(1)})',
                          titleStyle: TextStyle(
                            fontSize: _touchedIndex == index ? 20 : 16,
                            fontWeight: _touchedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                      centerSpaceRadius: 80,
                      sectionsSpace: 4,
                    ),
                  )
                : Center(
                    child: Text(
                      "No Data Available",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
