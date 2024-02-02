import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'verify_otp.dart';

class SendOtpPage extends StatefulWidget {
  static String verify = '';

  const SendOtpPage({super.key});

  @override
  State<SendOtpPage> createState() => _SendOtpPageState();
}

class _SendOtpPageState extends State<SendOtpPage> {
  // static String verify = "";

  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Otp"),
      ),
      body: ListView(
        children: [
          const Image(
              image: NetworkImage(
                  'https://cdni.iconscout.com/illustration/premium/thumb/man-using-mobile-phone-2839467-2371260.png')),
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "Enter your Phone Number"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+91${phoneController.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          SendOtpPage.verify = verificationId;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyOtp(),
                              ));
                          Fluttertoast.showToast(msg: "Sent OTP");
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    } catch (e) {
                      Fluttertoast.showToast(msg: "OTP Failed");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      side: BorderSide.none,
                      shape: StadiumBorder()),
                  child: const Text("Send Otp")),
            ),
          )
        ],
      ),
    );
  }
}
