import 'package:first_app/controller/controller.dart';
import 'package:first_app/model/model.dart';
import 'package:first_app/screens/add_new_screen.dart';
import 'package:first_app/screens/list_screen.dart';
import 'package:first_app/screens/total_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final cont;
  late List body;

  @override
  void initState() {
    // TODO: implement initState
    cont = Controller();
    initList(cont);
    body = [
      ListScreen(
        cont: cont,
      ),
      TotalScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Total'),
          ],
          currentIndex: cont.body_index.value,
          onTap: ((value) {
            cont.body_index.value = value;
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddNewPersonScreen(
                  cont: cont,
                ));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: body[cont.body_index.value],
      );
    });
  }
}
