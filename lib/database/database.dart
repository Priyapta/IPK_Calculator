import 'package:hive_flutter/hive_flutter.dart';

class Tododatabase {
  List<Map<String, dynamic>> todoList = [];
  final mybox = Hive.box("mybox");

    //{ "matkul": "",
    //"sks": "" ,
    // "semester": ,
    // "komponen": {},
    // "nilai_matkul": "",
    //"persentase": [],
    //}
  void create() {
    todoList = [];
    updateTask();
  }

  void loadTask() {
    List<dynamic> rawList = mybox.get("TODOLIST", defaultValue: []);
    todoList = List<Map<String, dynamic>>.from(
        rawList.map((item) => Map<String, dynamic>.from(item)));
  }

  void updateTask() {
    mybox.put("TODOLIST", todoList);
  }
}
