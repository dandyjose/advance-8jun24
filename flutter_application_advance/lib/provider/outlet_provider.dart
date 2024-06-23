import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_advance/provider/main_provider.dart';
import 'package:provider/provider.dart';

import '../UI/outlet/detail_outlet_page.dart';
import '../models/data_outlet.dart';

class OutletProvider extends ChangeNotifier {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('outlet');
  TextEditingController nameOutletField = TextEditingController();
  TextEditingController startTimeField = TextEditingController();
  TextEditingController endTimeField = TextEditingController();
  DataOutlet? dataOutlet;

  void insertNewOutlet(BuildContext context) {
    collectionReference.add({
      "name_outlet": nameOutletField.text,
      "hour_operation": {
        "start_time": startTimeField.text,
        "end_time": endTimeField.text
      }
    });
    Navigator.pop(context);
    context.read<MainProvider>().getListOutlet();
  }

  void detailOutlet(String id) async {
    var result = await collectionReference.doc(id).get();
    dataOutlet = DataOutlet(
        nameOutlet: result['name_outlet'],
        startTime: result['hour_operation']['start_time'],
        endTime: result['hour_operation']['end_time']);
    nameOutletField.text = dataOutlet!.nameOutlet ?? '';
    startTimeField.text = dataOutlet!.startTime ?? '';
    endTimeField.text = dataOutlet!.endTime ?? '';
    notifyListeners();
  }

  void updateOutlet(BuildContext context, String idDoc) {
    collectionReference.doc(idDoc).update({
      "name_outlet": nameOutletField.text,
      "hour_operation": {
        "start_time": startTimeField.text,
        "end_time": endTimeField.text
      }
    });
    Navigator.pop(context);
    context.read<MainProvider>().getListOutlet();
  }

  void moveDetailPage(BuildContext context, String idDoc) {
    detailOutlet(idDoc);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailOutletPage(),
        ));
  }
}
