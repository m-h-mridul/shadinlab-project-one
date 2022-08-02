import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  TextEditingController phoneController = TextEditingController(text: "+88");
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(),
                keyboardType: TextInputType.number,
              ),
              visible: otpVisibility,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (otpVisibility) {
                    verifyOTP();
                  } else {
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "Verify" : "Login")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Back to auth pages')),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('Failed', "Your verification Failed",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Color.fromARGB(255, 235, 130, 130),
            borderRadius: 15,
            margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
            colorText: Colors.white);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Get.snackbar('Failed', "Your codeAuto Retrieval is Timeout",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Color.fromARGB(255, 235, 130, 130),
            borderRadius: 15,
            margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
            colorText: Colors.white);
      },
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      Get.snackbar('Phone Auth', "You are logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent,
          borderRadius: 15,
          margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
          colorText: Colors.white);
      print("You are logged in successfully");
    });
  }
}
