import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_advance/UI/login_page.dart';
import 'package:flutter_application_advance/UI/product/detail_product_page.dart';
import 'package:flutter_application_advance/commons/constant.dart';
import 'package:flutter_application_advance/models/data_outlet.dart';
import 'package:flutter_application_advance/models/product_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/detail_product_response.dart';

class MainProvider extends ChangeNotifier {
  String title = 'Halaman Pertama';
  int indexTab = 0;
  String genderSelected = 'Male';
  String religionSelected = 'Budha';
  List<String> hobbySelected = [];

  String messageError = '';
  StateProduct stateDataProduct = StateProduct.initial;
  List<DataProduct> listProduct = <DataProduct>[];
  Data detailProduct = Data();
  List<DataOutlet> listOutlet = <DataOutlet>[];

  void changeBody(int index) {
    indexTab = index;
    if (indexTab == 2) {
      getListOutlet();
    }
    if (indexTab == 3) {
      getListProduct();
    }
    notifyListeners();
  }

  void selectGender(String value) {
    genderSelected = value;
    notifyListeners();
  }

  void selectReligion(String value) {
    religionSelected = value;
    notifyListeners();
  }

  void selectHobby(String value) {
    if (hobbySelected.contains(value)) {
      hobbySelected.removeWhere((element) => element == value);
    } else {
      hobbySelected.add(value);
    }
    notifyListeners();
  }

  void logout(BuildContext context) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  void getListProduct() async {
    stateDataProduct = StateProduct.loading;
    try {
      Response response = await Dio().get('http://10.0.2.2:8080/product');
      var result = ProductResponse.fromJson(response.data);

      if (result.data!.isEmpty) {
        stateDataProduct = StateProduct.noData;
        messageError = result.message ?? '';
      } else {
        stateDataProduct = StateProduct.success;
        listProduct = result.data!;
      }
    } catch (e) {
      stateDataProduct = StateProduct.error;
      messageError = e.toString();
    }
    notifyListeners();
  }

  void moveToDetail(BuildContext context, int id) {
    getDetailProduct(id);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailProductPage(),
        ));
  }

  void getDetailProduct(int id) async {
    try {
      Response response = await Dio().get('http://10.0.2.2:8080/product/$id');
      var result = DetailProductResponse.fromJson(response.data);
      detailProduct = result.data!;
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  void deleteProduct(BuildContext context, int id) async {
    try {
      Response response =
          await Dio().delete('http://10.0.2.2:8080/product/$id');
      var result = DetailProductResponse.fromJson(response.data);

      if (result.error == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error : ${result.message}')));
      } else {
        getListProduct();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error : ${e.toString()}')));
    }
    notifyListeners();
  }

  void getListOutlet() async {
    listOutlet = <DataOutlet>[];
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('outlet');
    var result = await collectionReference.get();
    var dataListOutlet = result.docs;
    for (var item in dataListOutlet) {
      var data = DataOutlet(
          nameOutlet: item['name_outlet'],
          startTime: item['hour_operation']['start_time'],
          endTime: item['hour_operation']['end_time']);
      listOutlet.add(data);
    }
    notifyListeners();
  }
}
