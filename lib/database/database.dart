import 'package:hive_flutter/hive_flutter.dart';

class Tododatabase {
  List<Map<String, dynamic>> todoList = [];
  final mybox = Hive.box("mybox");

  // void database() {
  //   todoList = [{}];
  // }
  void create() {
    todoList = [
      {
        "matkul": "matdis",
        "semester": "1",
        "komponen": {"test": "1"},
        "nilai_matkul": "A"
      },
    ];
    updateTask();
  }

  void loadTask() {
    List<dynamic> rawList = mybox.get("TODOLIST", defaultValue: []);
    todoList = List<Map<String, dynamic>>.from(
        rawList.map((item) => Map<String, dynamic>.from(item)));
  }

  void updateDatabase() {
    mybox.put("TODOLIST", todoList);
  }

  void updateTask() {
    mybox.put("TODOLIST", todoList);
  }
}