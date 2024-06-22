import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<LoginProvider>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PinCodeTextField(
              appContext: context, controller: provider.otpField, length: 6),
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () =>
                    context.read<LoginProvider>().loginWithPhone(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Submit')),
          ),

        ],
      ),
    );
  }
}
