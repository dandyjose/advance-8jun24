import 'package:flutter/material.dart';
import 'package:flutter_application_advance/provider/main_provider.dart';
import 'package:flutter_application_advance/provider/outlet_provider.dart';
import 'package:provider/provider.dart';

import '../../commons/constant.dart';
import '../outlet/form_outlet_page.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => context
                            .read<OutletProvider>()
                            .moveDetailPage(context, dataOutlet.id ?? ''),
                        icon: Column(
                          children: [
                            Icon(Icons.info, color: Colors.blue),
                            Text('View')
                          ],
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FormOutletPage(dataOutlet.id ?? ''),
                              ));
                        },
                        icon: Column(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            Text('Edit')
                          ],
                        )),
                    IconButton(
                        onPressed: () => context
                            .read<MainProvider>()
                            .deleteOutlet(dataOutlet.id ?? ''),
                        icon: Column(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            Text('Delete')
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
