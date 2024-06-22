import 'package:flutter/material.dart';
import 'package:flutter_application_advance/UI/phone_page.dart';
import 'package:flutter_application_advance/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        title: const Text(
          'Login Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [Icon(Icons.star), Icon(Icons.do_not_touch)],
      ),
      body: ListView(
        children: [
          // Image.asset('lib/assets/images/Google-flutter.png'),
          Image.network(
              'https://coaching.course-net.com/img/logo_course_net_dark.a81c3f77.png'),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 2,
            child: Card(
              elevation: 5,
              shadowColor: Colors.amber,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(color: Colors.red)),
              child: Form(
                key: provider.formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      child: TextFormField(
                        controller: provider.emailField,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == '') {
                            return 'Isi field ini';
                          } else if (!value!.contains('@')) {
                            return 'Bukan email, silahkan input ulang';
                          }
                          return null;
                        },
                        // onChanged: (value) {
                        //   setState(() {
                        //     email = value;
                        //   });
                        // },
                        decoration: const InputDecoration(
                            hintText: 'Masukkan Email',
                            labelText: 'Email',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blue,
                            ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      child: TextFormField(
                        controller: provider.usernameField,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == '') {
                            return 'Isi field ini';
                          }
                          return null;
                        },
                        // onChanged: (value) {
                        //   setState(() {
                        //     email = value;
                        //   });
                        // },
                        decoration: const InputDecoration(
                            hintText: 'Masukkan Username',
                            labelText: 'Username',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blue,
                            ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      child: TextFormField(
                        controller: provider.passwordField,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: provider.statusObsecure,
                        validator: (value) {
                          if (value == '') {
                            return 'Isi field ini';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Masukkan Password',
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<LoginProvider>()
                                      .setObsecurePass();
                                },
                                icon: Icon(provider.statusObsecure
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blue,
                            ))),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          // loginProcess();
                          context.read<LoginProvider>().processLogin(context);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          // loginProcess();
                          context.read<LoginProvider>().loginWithEmail(context);
                        },
                        child: const Text(
                          'Login with Email (Firebase)',
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          // loginProcess();
                          context
                              .read<LoginProvider>()
                              .registerWithEmail(context);
                        },
                        child: const Text(
                          'Register New Email (Firebase)',
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          // loginProcess();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhonePage(),
                              ));
                        },
                        child: const Text(
                          'Login with Phone (Firebase)',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () =>
                    context.read<LoginProvider>().loginWithGoogle(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Login with Google')),
          ),
          Text('Message : ${provider.messageError}')
        ],
      ),
    );
  }
}
