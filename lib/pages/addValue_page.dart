import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipk_kalkulator/components/component_field.dart';
import 'package:ipk_kalkulator/database/database.dart';

class AddValue extends StatefulWidget {
  const AddValue(
      {super.key,
      required this.db,
      required this.index,
      required this.namaMatkul});
  final Tododatabase db;
  final int index;
  final String namaMatkul;
  // final String

  @override
  State<AddValue> createState() => _AddValueState();
}

TextEditingController controllerComponent = new TextEditingController();
TextEditingController controllerNilai = new TextEditingController();
TextEditingController controllerPersentase = new TextEditingController();
int Nilai = int.parse(controllerNilai.text);

class _AddValueState extends State<AddValue> {
  int count = 0;

  void addComponent() {
    setState(() {
      count++;
    });
  }

  void saveTask() {
    widget.db.todoList[widget.index][widget.namaMatkul]
        [controllerComponent.text.toLowerCase()] = controllerNilai.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addComponent,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ComponentField(
                    controller: controllerComponent,
                    hintText: "Masukan Nama Komponen",
                  ),
                  ComponentField(
                    controller: controllerNilai,
                    hintText: "Masukan Nilai Matkul",
                  ),
                  ComponentField(
                    controller: controllerPersentase,
                    hintText: "Masukan Persentase Komponen",
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
