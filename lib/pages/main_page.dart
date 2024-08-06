import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
        "komponen": {},
        "persentase": [],
      });
      controllerMatkul.clear();
      db.updateTask();

      print(db.todoList[0]["sks"]);
      print(db.todoList[0]["matkul"]);

      Navigator.of(context).pop();
    });
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void addTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
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
    return Scaffold(
      appBar: AppBar(
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
            padding: const EdgeInsets.all(8.0),
            child: SemiCircularProgressBar(progress: 0.875),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return IpkTile(
                      judulMatkul: db.todoList[index]["matkul"],
                      nilaiMatkul: db.todoList[index]["nilaiMatkul"].toString(),
                      sksMatkul: db.todoList[index]["sks"],
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
