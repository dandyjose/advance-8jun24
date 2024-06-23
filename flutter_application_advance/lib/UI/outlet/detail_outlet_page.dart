import 'package:flutter/material.dart';
import 'package:flutter_application_advance/provider/outlet_provider.dart';
import 'package:provider/provider.dart';

class DetailOutletPage extends StatelessWidget {
  const DetailOutletPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<OutletProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Outlet'),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name Outlet',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(provider.dataOutlet!.nameOutlet ?? '')
              ],
            ),
          ),
          // Container(
          //   width: MediaQuery.sizeOf(context).width,
          //   padding: EdgeInsets.all(10),
          //   margin: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //       border: Border.all(color: Colors.lightBlue),
          //       borderRadius: BorderRadius.all(Radius.circular(15))),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Description Product',
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          //       ),
          //       Text(provider.detailProduct.descProduct ?? '')
          //     ],
          //   ),
          // ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Open Store',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(provider.dataOutlet!.startTime.toString())
              ],
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Close Store',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(provider.dataOutlet!.endTime.toString())
              ],
            ),
          ),
        ],
      ),
    );
  
  }
}