import 'package:first_app/controller/controller.dart';
import 'package:first_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hive_flutter/adapters.dart';

class AddNewPersonScreen extends StatelessWidget {
  Controller cont;
  AddNewPersonScreen({super.key, required this.cont});

  final name = TextEditingController();
  final amount = TextEditingController();
  final _fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Person'),
        actions: [
          TextButton(
            onPressed: ()async{final db = await Hive.openBox<PersonModel>('db');await db.clear();personlist.clear();update(cont);},
            child:Text('Clear Data',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _fkey,
          child: Column(
            children: [
              SizedBox(height: 50),
              textfield('Name', name, TextInputType.text),
              SizedBox(height: 30),
              textfield('Amount', amount, TextInputType.number),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RadioButton(val: true, cont: cont),
                  RadioButton(val: false, cont: cont),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if(_fkey.currentState!.validate()){
                    PersonModel(
                          name: name.text,
                          amount: amount.text,
                          paid: cont.group_value.value)
                      .addPerson(cont);
                  Get.back();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget textfield(String name, TextEditingController cont, TextInputType type) {
  return TextFormField(
    controller: cont,
    keyboardType: type,
    decoration: InputDecoration(
      hintText: name,
      border: OutlineInputBorder(),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    ),
    validator: ((value) {
      return value!.isEmpty ? 'Please Enter Some Details' : null;
    }),
  );
}

Widget RadioButton({required bool val, required Controller cont}) {
  return Obx(() {
    return Row(
      children: [
        Radio(
          value: val,
          groupValue: cont.group_value.value,
          onChanged: (value) {
            if (value != null) cont.group_value.value = value;
          },
        ),
        Text(val == true ? 'Paid' : 'Pending')
      ],
    );
  });
}
