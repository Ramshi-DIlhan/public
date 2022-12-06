import 'package:first_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class TotalScreen extends StatelessWidget {
  const TotalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sumUp();
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100),
          text('Total', (paid+pend).toString(), Colors.blue),
          SizedBox(height: 40),
          text('Paid', paid.toString(), Colors.green),
          SizedBox(height: 40),
          text('Pending', pend.toString(), Colors.red),
        ],
      ),
    );
  }
}

Widget text(String title,String value, Color clr){
  return Text(
    '$title : $value',
    style: TextStyle(
      color: clr,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
  );
}