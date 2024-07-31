import 'package:flutter/material.dart';
import 'package:ipk_kalkulator/components/component_field.dart';

class AddValue extends StatefulWidget {
  const AddValue({super.key});

  @override
  State<AddValue> createState() => _AddValueState();
}

class _AddValueState extends State<AddValue> {
  int count = 0;

  void addComponent() {
    setState(() {
      count++;
    });
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
              ComponentField(),
            ],
          );
        },
      ),
    );
  }
}
