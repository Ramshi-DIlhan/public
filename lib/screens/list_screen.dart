import 'package:first_app/controller/controller.dart';
import 'package:first_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ListScreen extends StatelessWidget {
  Controller cont;
  ListScreen({super.key, required this.cont});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.green,
              tabs: [
                Tab(
                  text: 'Paid',
                ),
                Tab(text: 'Pending'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PaidList(cont),
                  PendingList(cont),
                ],
              ),
            )
          ],
        ));
  }
}

Widget PaidList(Controller cont) {
  return Obx(() {
    print(cont.i.value);
    return ListView.builder(
      itemBuilder: ((context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.green[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paidlist[index].name,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    paidlist[index].amount,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {delete(paidlist[index], cont);},
                icon: Icon(Icons.delete, color: Colors.red),
              )
            ],
          ),
        );
      }),
      itemCount: paidlist.length,
    );
  });
}

Widget PendingList(Controller cont) {
  return Obx(() {
    print(cont.i.value);
    return ListView.separated(
      itemBuilder: ((context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pendinglist[index].name,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    pendinglist[index].amount,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Row(
                children: [
                   IconButton(
                    onPressed: (){moveToPaid(pendinglist[index], cont);},
                    icon: Icon(Icons.verified,color: Colors.green,),
                  ),
                  IconButton(
                    onPressed: () {delete(pendinglist[index], cont);},
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                 
                ],
              )
            ],
          ),
        );
      }),
      separatorBuilder: ((context, index) => Divider()),
      itemCount: pendinglist.length,
    );
  });
}
