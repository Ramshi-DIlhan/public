import 'package:first_app/controller/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';

List<PersonModel> personlist = [];
List<PersonModel> paidlist = [];
List<PersonModel> pendinglist = [];
int paid = 0;
int pend = 0;

@HiveType(typeId: 0)
class PersonModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String amount;
  @HiveField(2)
  bool paid;
  PersonModel({required this.name, required this.amount, required this.paid});

  void addPerson(Controller cont) {
    personlist.add(PersonModel(name: name, amount: amount, paid: paid));
    update(cont);
    cont.i.value++;
    print('added');
  }
}

void sumUp() {
  paid=0;
  pend=0;
  paidlist.forEach((element) {
    paid += int.parse(element.amount);
  });
  pendinglist.forEach((element) {
    pend += int.parse(element.amount);
  });
}

void delete(PersonModel p, Controller cont){
  personlist.remove(p);
  update(cont);
}

void initList(Controller cont)async{
  final db = await Hive.openBox<PersonModel>('db');
  personlist.clear();
  personlist.addAll(db.values);
  update(cont);
}

void update(Controller cont)async{
  final db = await Hive.openBox<PersonModel>('db');
  db.clear();
  db.addAll(personlist);
  paidlist.clear();
  pendinglist.clear();
  personlist.sort((a, b) => a.name.compareTo(b.name));
  personlist.forEach((p) {
    p.paid
    ? paidlist.add(p)
        : pendinglist.add(p);
   });
   paidlist.sort((a, b) => a.name.compareTo(b.name));
   pendinglist.sort((a, b) => a.name.compareTo(b.name));
   cont.i.value++;
} 

// geeksforgeeks.sort((a, b) => a.length.compareTo(b.length));


void moveToPaid(PersonModel person,Controller cont){
  personlist.remove(person);
  person.paid=true;
  personlist.add(person);
  update(cont);
  cont.i.value++;
}