import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ipk_kalkulator/Method/Rumus.dart';
import 'package:ipk_kalkulator/components/DialogBox.dart';
import 'package:ipk_kalkulator/components/Ipktile.dart';
import 'package:ipk_kalkulator/components/piechart.dart';
import 'package:ipk_kalkulator/components/show_ip.dart';
import 'package:ipk_kalkulator/database/database.dart';
import 'package:ipk_kalkulator/pages/addValue_page.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int selectedSemester = 1;
  final mybox = Hive.box("mybox");
  Tododatabase db = Tododatabase();
  String sks = "1";
  String nilaiMatkul = "";
  String semester = "1";
  Map<String, double> myMaps = {};
  List<Map<String, dynamic>> todoList = [];
  double ipk = 0;

  TextEditingController controllerMatkul = TextEditingController();

  // Correct filter method that works on todoList
  List<Map<String, dynamic>> filterBySemester(int semester) {
    todoList = db.todoList;

    return todoList
        .where((task) => int.parse(task["semester"].toString()) == semester)
        .toList();
  }

  @override
  void initState() {
    super.initState();

    // Load data from Hive
    if (mybox.get("TODOLIST") == null) {
      db.create();
      db.updateTask();
    } else {
      db.loadTask();
    }

    // Load todoList initially
    setState(() {
      todoList = db.todoList;
      // // Load all tasks initially
      todoList = filterBySemester(selectedSemester);
      updatePieData();
    });
  }

  void updatePieData() {
    setState(() {
      myMaps = {}; // Reset myMaps
      addKeys(db.todoList, myMaps);
      addValues(db.todoList, myMaps);
      ipk = konversiBobot(HitungIpk(db.todoList));
    });
  }

  void updatePriorityQueue() {
    setState(() {
      // Sorting todoList by 'semester'
      todoList.sort((a, b) => int.parse(a['semester'].toString())
          .compareTo(int.parse(b['semester'].toString())));
    });
  }

  void saveTask() {
    if (controllerMatkul.text.isEmpty) {
      wrongMessage("Isi Nama Matkul");
    } else {
      setState(() {
        db.todoList.add({
          "matkul": controllerMatkul.text,
          "sks": sks,
          "semester": semester,
          "index": "",
          "nilaiMatkul": 0,
          "komponen": {},
          "persentase": [],
          "lulus": false
        });
        controllerMatkul.clear();
        updatePriorityQueue();
        db.updateTask();
        updatePieData();
        // todoList = filterBySemester(int.parse(semester));
      });
      Navigator.of(context).pop();
    }
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.updateTask();
      // todoList = db.todoList; // Re-load the full list
      todoList = filterBySemester(selectedSemester);
      updatePieData();
    });
  }

  void addTask() {
    setState(() {
      semester = "1";
    });
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          hintText: "Input Nama Matkul",
          controller: controllerMatkul,
          onSksChanged: (value) {
            setState(() {
              sks = value;
            });
          },
          onSemesterChanged: (value) {
            setState(() {
              semester = value;
            });
          },
          saveTask: saveTask,
          cancel: cancel,
        );
      },
    );
  }

  int getObjectinDB(Map<String, dynamic> data) {
    for (int i = 0; i < db.todoList.length; i++) {
      if (db.todoList[i] == data) {
        return i;
      }
    }
    return 0;
  }

  void wrongMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showIPK() {
    // Calculate the IPK value
    double ipk = HitungIpk(db.todoList);

    // Show the IPK in an AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("IPK Anda"),
          content: Text(
            "Nilai IPK: ${ipk.toStringAsFixed(2)}", // Display IPK with 2 decimal points
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 166, 183, 170),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "IPKCALC",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: showIPK,
                  child: Text("IPK"),
                ),
                IconButton(
                  onPressed: addTask,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            // DropdownButton to select the semester
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(115, 94, 73, 73), // Background color
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  border: Border.all(
                      color: Colors.grey, width: 1.0), // Border styling
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Shadow spread
                      blurRadius: 4, // Shadow blur
                      offset: Offset(0, 2), // Shadow position
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedSemester,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedSemester = newValue!;
                        todoList = filterBySemester(selectedSemester);
                      });
                    },
                    items: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          'Semester $value',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white, // Text color
                          ),
                        ),
                      );
                    }).toList(),
                    icon: Icon(
                      Icons.arrow_drop_down, // Custom dropdown icon
                      color: Colors.blue, // Icon color
                    ),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87, // Text styling
                    ),
                    dropdownColor: const Color.fromARGB(
                        115, 94, 73, 73), // Dropdown menu background color
                  ),
                ),
              ),
            ),

            // Check if todoList is empty
            if (db.todoList.isEmpty)
              Center(child: Text("No tasks available."))
            else
              Column(
                children: [
                  // CustomPie widget for PieChart
                  if (hasValidData(myMaps))
                    SizedBox(
                      height: 400,
                      width: 400,
                      child: CustomPie(
                        key: ValueKey(myMaps.hashCode),
                        value: myMaps,
                      ),
                    ),

                  // ListView.builder for todoList items
                  ...todoList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IpkTile(
                        judulMatkul: item["matkul"],
                        nilaiMatkul: item["nilaiMatkul"].toString(),
                        semester: item["semester"],
                        sksMatkul: item["sks"].toString(),
                        index: item["index"],
                        lulus: item["lulus"],
                        deleteFunction: (context) =>
                            deleteTask(getObjectinDB(item)),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      AddValue(
                                selectedSemester: selectedSemester,
                                db: db,
                                index: getObjectinDB(item),
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
                            ),
                          );
                          setState(() {
                            updatePriorityQueue();
                            // todoList = db.todoList;
                            todoList = filterBySemester(selectedSemester);
                            updatePieData();
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
          ],
        ));
  }
}
