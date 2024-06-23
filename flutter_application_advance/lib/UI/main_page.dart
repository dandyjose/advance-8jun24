import 'package:flutter/material.dart';
import 'package:flutter_application_advance/UI/main/favorite_page.dart';
import 'package:flutter_application_advance/UI/main/history_payment_page.dart';
import 'package:flutter_application_advance/UI/main/payment_page.dart';
import 'package:flutter_application_advance/UI/main/profile_page.dart';
import 'package:flutter_application_advance/UI/product/form_product_page.dart';
import 'package:flutter_application_advance/commons/color_pallete.dart';
import 'package:flutter_application_advance/commons/constant.dart';
import 'package:flutter_application_advance/provider/main_provider.dart';
import 'package:provider/provider.dart';

import '../commons/widget/app_bar_custom.dart';
import '../provider/product_provider.dart';

class MainPage extends StatelessWidget {
  final String email;
  final String username;
  const MainPage(this.email, this.username, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<MainProvider>();
    return Scaffold(
        drawer: navigationDrawer(context),
        appBar: AppBar(
          title: Text('Main Page'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<MainProvider>().logout(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.indexTab > 4 ? 1 : provider.indexTab,
            onTap: (value) => context.read<MainProvider>().changeBody(value),
            // unselectedItemColor: primaryColor,
            // unselectedLabelStyle: TextStyle(color: primaryColor),
            items: listBottomItem
                .map((e) => BottomNavigationBarItem(
                    icon: e.icon,
                    label: e.label,
                    backgroundColor: primaryColor))
                .toList()),
        floatingActionButton: provider.indexTab == 3
            ? FloatingActionButton(
                onPressed: () {
                  context.read<ProductProvider>().initialData(0);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormProductPage(0),
                      ));
                },
                child: Icon(Icons.add),
              )
            : SizedBox(),
        body: bodyMain(provider.indexTab));
  }

  Widget bodyMain(int index) {
    switch (index) {
      case 0:
        return ProfilePage(username);
      case 1:
        return const PaymentPage();
      case 2:
        return const HistoryPaymentPage();
      case 3:
        return const FavoritePage();

      default:
        return const Center(
          child: Row(
            children: [Text('Navigation Drawer')],
          ),
        );
    }
  }

  Widget navigationDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          headerDrawer(),
          ListTile(
            leading: const Icon(Icons.portrait),
            title: const Text('My Profile'),
            onTap: () {
              context.read<MainProvider>().changeBody(10);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget headerDrawer() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: primaryColor),
        otherAccountsPictures: [
          Stack(
            children: [
              const Icon(
                Icons.star,
                color: Colors.white,
              ),
              Positioned(
                right: 5,
                top: -5,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.cyan, shape: BoxShape.circle),
                    child: const Text(
                      '2',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )),
              )
            ],
          ),
          const Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
        ],
        currentAccountPicture: ClipOval(
          child: Image.network(
              'https://marketplace.canva.com/EAFHfL_zPBk/1/0/1600w/canva-yellow-inspiration-modern-instagram-profile-picture-kpZhUIzCx_w.jpg'),
        ),
        accountName: Text(username),
        accountEmail: Text(email));
  }
}
