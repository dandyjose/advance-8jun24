import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<LoginProvider>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: InternationalPhoneNumberInput(
                  onInputChanged: (value) {
                    provider.phoneNumber = value.phoneNumber ?? '0';
                  },
                  textFieldController: provider.phoneField,
                  countries: ['ID'],
                  initialValue: PhoneNumber(phoneNumber: 'ID'),
                  inputDecoration: InputDecoration(
                      hintText: 'Masukkan nomor Handphone Anda',
                      labelText: 'Handphone',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.green))),
                ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  context.read<LoginProvider>().verificationNumber(context);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                )),

          Text('Message : ${provider.messageError}')
          ],
        ),
      ),
    );
  }
}
