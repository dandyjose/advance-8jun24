import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_advance/UI/main_page.dart';
import 'package:flutter_application_advance/UI/otp_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailField = TextEditingController();
  TextEditingController usernameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  TextEditingController phoneField = TextEditingController();
  TextEditingController otpField = TextEditingController();

  bool statusObsecure = true;

  String messageError = '';
  String verifId = '';
  String phoneNumber = '0';

  void setObsecurePass() {
    statusObsecure = !statusObsecure;
    notifyListeners();
  }

  void processLogin(BuildContext context) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    if (formKey.currentState!.validate()) {
      await _sharedPreferences.setString('username', usernameField.text);
      await _sharedPreferences.setString('email', emailField.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(emailField.text, usernameField.text),
          ));
    }
    notifyListeners();
  }

  void loginWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User dataUser = userCredential.user!;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(dataUser.email ?? '-', dataUser.uid),
          ));
    } on FirebaseAuthException catch (error) {
      messageError = error.message!;
    } catch (e) {
      messageError = e.toString();
    }

    notifyListeners();
  }

  void loginWithEmail(BuildContext context) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailField.text, password: passwordField.text);
      User dataUser = result.user!;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(dataUser.email ?? '-', dataUser.uid),
          ));
    } on FirebaseAuthException catch (error) {
      messageError = error.message!;
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  void registerWithEmail(BuildContext context) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailField.text, password: passwordField.text);
      User dataUser = result.user!;
      Fluttertoast.showToast(
          msg: 'Success Register with UID : ${dataUser.uid}');
    } on FirebaseAuthException catch (error) {
      messageError = error.message!;
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  void verificationNumber(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        //  userCredential = await auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        messageError = error.message ?? '-';
        notifyListeners();
      },
      codeSent: (verificationId, forceResendingToken) {
        verifId = verificationId;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OTPPage(),
            ));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  void loginWithPhone(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential? userCredential;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifId, smsCode: otpField.text);

      userCredential = await auth.signInWithCredential(credential);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
                userCredential!.user!.phoneNumber ?? '-',
                userCredential.user!.uid),
          ));
    } catch (e) {}
  }
}
