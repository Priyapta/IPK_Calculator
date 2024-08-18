import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ipk_kalkulator/Method/Rumus.dart';
import 'package:ipk_kalkulator/components/DialogBox.dart';
import 'package:ipk_kalkulator/components/Ipktile.dart';
import 'package:ipk_kalkulator/components/piechart.dart';
import 'package:ipk_kalkulator/database/database.dart';
import 'package:ipk_kalkulator/pages/addValue_page.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final mybox = Hive.box("mybox");
  Tododatabase db = Tododatabase();
  String sks = "1";
  String nilaiMatkul = "";
  String semester = "1";
  Map<String, double> myMaps = {};
  List todoList = [];
  double ipk = 0;

  TextEditingController controllerMatkul = TextEditingController();

  @override
  void initState() {
    if (mybox.get("TODOLIST") == null) {
      db.create();
      db.updateTask();
    } else {
      db.loadTask();
    }
    setState(() {
      todoList = db.todoList;
    });
    updatePieData();
    super.initState();
  }

  void updatePieData() {
    setState(() {
      myMaps = Map.from(myMaps);
      addKeys(db.todoList, myMaps);
      addValues(db.todoList, myMaps);
      ipk = konversiBobot(HitungIpk(db.todoList));
    });
  }

  void wrongMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.red,
            title: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Text(message)),
          );
        });
  }

  void saveTask() {
    if (controllerMatkul.text.isEmpty) {
      return wrongMessage("Isi Nama Matkul");
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
        db.updateTask();
      });
    }

    Navigator.of(context).pop();
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void addTask() {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    updatePieData();

    return Scaffold(
      backgroundColor: Color.fromRGBO(234, 231, 220, 1.000),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 90,
            ),
            Text(
              "IPK CALCULATOR",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: addTask,
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: FirebaseAuth.instance.signOut,
                icon: Icon(Icons.logout),
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length + 1, // +1 for the PieChart
        itemBuilder: (context, index) {
          if (index == 0) {
            // The first item is the PieChart
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 100),
              child: SizedBox(
                height: 400,
                width: 400,
                child: CustomPie(
                  key: ValueKey(myMaps.hashCode),
                  value: myMaps,
                ),
              ),
            );
          } else {
            // Subsequent items are the todoList items
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IpkTile(
                judulMatkul: db.todoList[index - 1]
                    ["matkul"], // index - 1 because the first item is PieChart
                nilaiMatkul: db.todoList[index - 1]["nilaiMatkul"].toString(),
                semester: db.todoList[index - 1]["semester"],
                sksMatkul: db.todoList[index - 1]["sks"].toString(),
                index: db.todoList[index - 1]["index"],
                lulus: db.todoList[index - 1]["lulus"],
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddValue(
                        db: db,
                        index: index - 1,
                      ),
                    ),
                  );
                  setState(() {
                    todoList = db.todoList;
                    updatePieData();
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
