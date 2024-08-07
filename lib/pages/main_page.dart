import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ipk_kalkulator/Method/Rumus.dart';
import 'package:ipk_kalkulator/components/DialogBox.dart';
import 'package:ipk_kalkulator/components/Ipktile.dart';
import 'package:ipk_kalkulator/components/circularProgess.dart';
import 'package:ipk_kalkulator/database/database.dart';
import 'package:ipk_kalkulator/pages/addValue_page.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

void onPressed() {
  FirebaseAuth.instance.signOut();
}

TextEditingController controllerMatkul = TextEditingController();

class _mainPageState extends State<mainPage> {
  final mybox = Hive.box("mybox");
  Tododatabase db = Tododatabase();
  String sks = "1";
  String nilaiMatkul = "";
  String semester = "1";
  // final ValueNotifier<String> onSksChanged = ValueNotifier<String>("1");
  // final ValueNotifier<String> semesterNotifier = ValueNotifier<String>("1");
  List todoList = [];
  double ipk = 0;
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
    super.initState();
  }

  void saveTask() {
    setState(() {
      db.todoList.add({
        "matkul": controllerMatkul.text,
        "sks": sks,
        "semester": semester,
        "index": "",
        "nilaiMatkul": "",
        "komponen": {},
        "persentase": [],
        "lulus": false
      });
      controllerMatkul.clear();
      db.updateTask();
    });
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
    ipk = konversiBobot(HitungIpk((db.todoList)));

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
                onPressed: onPressed,
                icon: Icon(Icons.logout),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 30),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SemiCircularProgressBar(progress: ipk / 4),
              ],
            )),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return IpkTile(
                      judulMatkul: db.todoList[index]["matkul"],
                      nilaiMatkul: db.todoList[index]["nilaiMatkul"].toString(),
                      sksMatkul: db.todoList[index]["sks"],
                      index: db.todoList[index]["index"],
                      lulus: db.todoList[index]["lulus"],
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddValue(
                                    db: db,
                                    index: index,
                                  )),
                        );
                        setState(() {
                          todoList = db.todoList;
                        });
                      });
                }),
          ),
        ],
      ),
    );
  }
}
