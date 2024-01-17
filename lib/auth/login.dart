import 'package:FarmXpert/misc/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String verificationId = "";
  bool sentOtp = false;
  final TextEditingController _otpCodeController = TextEditingController();
  final TextEditingController _phoneInputController = TextEditingController();

  sendVerificationCode(BuildContext context, bool isResend) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return const SimpleDialog(
            elevation: 10,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          );
        });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneInputController.text.trim(),
        verificationCompleted: (creds) {
          Navigator.pop(config.navigatorKey.currentContext!);
        },
        verificationFailed: (err) {
          if (err.code == "invalid-phone-number") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "The phone number you entered is invalid, please try again.",
                ),
              ),
            );
          } else if (isResend) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "An error occurred while resending the code.",
                ),
              ),
            );
          }
          Navigator.pop(config.navigatorKey.currentContext!);
        },
        codeSent: (vId, fRToken) {
          verificationId = vId;
          sentOtp = true;
          setState(() => {});
          if (isResend) {
            _otpCodeController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Code has been resent.",
                ),
              ),
            );
          }
          Navigator.pop(config.navigatorKey.currentContext!);
        },
        codeAutoRetrievalTimeout: (_) {});
  }

  List<Widget> getBottomWidgets(BuildContext context, Size size) {
    return sentOtp
        ? [
            const Text(
              "Please enter the OTP sent to your mobile number below:\n",
            ),
            Pinput(
              length: 6,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsRetrieverApi,
              defaultPinTheme: PinTheme(
                width: 50,
                height: 53,
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade50,
                  border: Border.all(color: Colors.lightGreen.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: _otpCodeController,
              onCompleted: (String otp) async {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) {
                      return const SimpleDialog(
                        elevation: 10,
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
                try {
                  final authorizer = FirebaseAuth.instance;
                  await authorizer.signInWithCredential(
                    PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otp,
                    ),
                  );
                  Navigator.pop(config.navigatorKey.currentContext!);
                  if (authorizer.currentUser!.displayName == null) {
                    await config.navigatorKey.currentState!
                        .pushNamed("/signup");
                    // await authorizer.currentUser!
                    // .updateDisplayName("Parmeshwar Kumar");
                  } else {
                    await config.navigatorKey.currentState!
                        .pushNamedAndRemoveUntil("/home", (route) => false);
                  }
                  return;
                } on FirebaseAuthException catch (e) {
                  // TODO: Report errors to backend server
                  String errorMessage = "Unknown error occured.";
                  if (e.code == "invalid-verification-code") {
                    errorMessage =
                        "The verification code you entered is invalid.";
                  }
                  Navigator.pop(config.navigatorKey.currentContext!);
                  config.scaffoldKey.currentState!.showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                    ),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      height: -1.5,
                      fontFamily: "SF Pro Display",
                      fontSize: size.width / 27,
                      color: config.chosenTheme.primaryColorLight,
                    ),
                  ),
                  onPressed: () async {
                    await sendVerificationCode(context, true);
                  },
                ),
              ],
            ),
          ]
        : [
            SizedBox(
              // width: size.width / 2,
              height: size.height / 12,
              child: TextField(
                controller: _phoneInputController,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: size.height / 35,
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
                showCursor: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(243, 244, 245, 1),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter Phone Number",
                  hintStyle: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: size.height / 40,
                    color: const Color.fromRGBO(172, 179, 183, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            SizedBox(
              height: size.height / 16,
              width: size.width / 1.3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: config.chosenTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await sendVerificationCode(context, false);
                },
                child: Text(
                  "Send OTP",
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontWeight: FontWeight.bold,
                    fontSize: size.height / 40,
                    height: -0.2,
                  ),
                ),
              ),
            ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 10,
          ),
          child: ListView(
              children: <Widget>[
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Center(
                      child: SizedBox(
                        height: size.height / 5,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: "Jomhuria",
                            fontSize: 128,
                            height: 0,
                            fontWeight: FontWeight.normal,
                            color: config.chosenTheme.titleTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 2.5,
                      width: size.width,
                      child: SvgPicture.asset(
                        "assets/images/auth.svg",
                      ),
                    ),
                    SizedBox(
                      height: size.height / 17,
                    )
                  ] +
                  getBottomWidgets(context, size)),
        ),
      ),
    );
  }
}
