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
    return ListView.separated(
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(paidlist[index].name),
          subtitle: Text(paidlist[index].amount),
          trailing: IconButton(
            onPressed: (){delete(paidlist[index], cont);},
            icon: Icon(Icons.delete, color: Colors.red,),
          ),
        );
      }),
      separatorBuilder: ((context, index) => Divider()),
      itemCount: paidlist.length,
    );
  });
}

Widget PendingList(Controller cont) {
  return Obx(() {
    print(cont.i.value);
    return ListView.separated(
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(pendinglist[index].name),
          subtitle: Text(pendinglist[index].amount),
          trailing: SizedBox(
            width: 120,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    moveToPaid(pendinglist[index], cont);
                  },
                  child: Text('Paid'),
                ),
                IconButton(
                  onPressed: () {delete(pendinglist[index], cont);},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      separatorBuilder: ((context, index) => Divider()),
      itemCount: pendinglist.length,
    );
  });
}
