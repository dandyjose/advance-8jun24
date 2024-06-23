import 'package:flutter/material.dart';
import 'package:flutter_application_advance/provider/main_provider.dart';
import 'package:provider/provider.dart';

import '../../commons/constant.dart';

class HistoryPaymentPage extends StatelessWidget {
  const HistoryPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<MainProvider>();
    return ListView.builder(
      itemCount: provider.listOutlet.length,
      itemBuilder: (context, index) {
        var dataOutlet = provider.listOutlet[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataOutlet.nameOutlet ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Open Store : ${dataOutlet.startTime}'),
                Text('Close Order : ${dataOutlet.endTime}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
