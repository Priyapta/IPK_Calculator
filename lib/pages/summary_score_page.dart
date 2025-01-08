import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ipk_kalkulator/pages/main_page.dart';

class AppColors {
  static const Color contentColorYellow = Color(0xFFFFEB3B);
  static const Color contentColorRed = Color(0xFFF44336);
  static const Color contentColorOrange = Color(0xFFFF9800);
  static const Color contentColorCyan = Color(0xFF00BCD4);
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color mainGridLineColor = Color(0xff37434d);
}

class SummaryScorePage extends StatefulWidget {
  SummaryScorePage({super.key, required this.isCliked});
  late bool isCliked;

  @override
  State<SummaryScorePage> createState() => _SummaryScorePageState();
}

class _SummaryScorePageState extends State<SummaryScorePage> {
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 97, 102, 98),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.isCliked = !widget.isCliked;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => mainPage()),
                    );
                  });
                },
                icon: Icon(
                  Icons.home,
                  color: !widget.isCliked ? Colors.green[400] : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      widget.isCliked = !widget.isCliked;
                      // showIPK();
                    },
                  );
                },
                icon: Icon(
                  Icons.school_rounded,
                  color: widget.isCliked ? Colors.green[400] : Colors.black,
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: height / 1.46,
              width: width,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(70)),
                  image: DecorationImage(
                      image: AssetImage('assets/summary.jpg'),
                      fit: BoxFit.cover)),
              // child: Image.asset('assets/summary.jpg'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height / 4,
                width: width,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("IPK Kamu", style: TextStyle(fontSize: 25)),
                              Column(
                                children: [
                                  Text(
                                    "4.0",
                                    style: TextStyle(fontSize: 25),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Column(
        //     children: [
        //       Container(
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(12),
        //             color: Colors.grey[300]),
        //         padding: EdgeInsets.all(10),
        //         child: Column(
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 CircleAvatar(
        //                   child: Icon(Icons.people),
        //                 ),
        //                 Text("IPK", style: TextStyle(fontSize: 25)),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "4.0",
        //                       style: TextStyle(fontSize: 25),
        //                     )
        //                   ],
        //                 )
        //               ],
        //             )
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
