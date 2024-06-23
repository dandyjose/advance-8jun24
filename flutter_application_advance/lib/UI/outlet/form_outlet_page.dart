import 'package:flutter/material.dart';
import 'package:flutter_application_advance/provider/outlet_provider.dart';
import 'package:provider/provider.dart';

class FormOutletPage extends StatefulWidget {
  final String id;
  const FormOutletPage(this.id, {super.key});

  @override
  State<FormOutletPage> createState() => _FormOutletPageState();
}

class _FormOutletPageState extends State<FormOutletPage> {
  @override
  void initState() {
    super.initState();
    if (widget.id != '') {
      context.read<OutletProvider>().detailOutlet(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<OutletProvider>();
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.id == '' ? 'Form Insert Outlet' : 'Form Edit Outlet'),
        actions: [
          TextButton(
              onPressed: () => widget.id == ''
                  ? context.read<OutletProvider>().insertNewOutlet(context)
                  : context
                      .read<OutletProvider>()
                      .updateOutlet(context, widget.id),
              child: Text(widget.id == '' ? 'Submit' : 'Update'))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: TextFormField(
              controller: provider.nameOutletField,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == '') {
                  return 'Isi field ini';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Insert Name Outlet',
                  labelText: 'Name Outlet',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blue,
                  ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: TextFormField(
              controller: provider.startTimeField,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == '') {
                  return 'Isi field ini';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Insert Open Store',
                  labelText: 'Open Store',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blue,
                  ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: TextFormField(
              controller: provider.endTimeField,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == '') {
                  return 'Isi field ini';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Insert Close Order',
                  labelText: 'Close Order',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blue,
                  ))),
            ),
          ),
        ],
      ),
    );
  }
}
