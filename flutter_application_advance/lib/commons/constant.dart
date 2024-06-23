import 'package:flutter/material.dart';
import 'package:flutter_application_advance/models/order_model.dart';
import 'package:flutter_application_advance/models/tab_item.dart';

List<TabItem> listBottomItem = [
  TabItem(
      const Icon(
        Icons.portrait,
      ),
      'My Profile'),
  TabItem(
      const Icon(
        Icons.monetization_on,
      ),
      'Payment'),
  TabItem(
      const Icon(
        Icons.store,
      ),
      'Outlet'),
  TabItem(
      const Icon(
        Icons.star,
      ),
      'Favorite'),
  // BottomNavigationBarItem(
  //     icon: Icon(
  //       Icons.portrait,
  //     ),
  //     backgroundColor: primaryColor,
  //     label: 'My Profile'),
  // BottomNavigationBarItem(
  //     backgroundColor: primaryColor,
  //     icon: Icon(Icons.monetization_on),
  //     label: 'Payment'),
  // BottomNavigationBarItem(
  //     backgroundColor: primaryColor,
  //     icon: Icon(Icons.pie_chart),
  //     label: 'History Payment'),
  // BottomNavigationBarItem(
  //     backgroundColor: primaryColor, icon: Icon(Icons.star), label: 'Favorites')
];

List<OrderModel> listOrder = [
  for (var index = 0; index < 50; index++)
    OrderModel(
        'TRX00$index',
        'Product $index',
        DateTime.now().toString(),
        index.isOdd ? 'Waiting' : 'Payment',
        index.isEven ? index * 0.1 : index * 2)
];

List<String> listReligions = [
  'Islam',
  'Katholik',
  'Protestan',
  'Hindu',
  'Budha',
  'Konghuchu'
];
List<String> listHobbies = ['Basketball', 'Soccer', 'Swim', 'Racing'];

const String mainPage = 'Main Page xxxx';

enum StateProduct { initial, loading, error, noConnection, noData, success }
