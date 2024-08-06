import 'package:hive_flutter/hive_flutter.dart';

class Tododatabase {
  List<Map<String, dynamic>> todoList = [];
  final mybox = Hive.box("mybox");

  // void database() {
  //   todoList = [{}];
  // }
  void create() {
    //{ "matkul": "",
    //"sks": "" ,
    // "semester": ,
    // "komponen": {},
    // "nilai_matkul": "",
    //"persentase": [],
    //}
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
