import 'package:AgroConnect/helpers/name_helper.dart';
import 'package:AgroConnect/misc/config.dart';
import 'package:AgroConnect/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

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
              Center(
                child: SizedBox(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: "Jomhuria",
                      fontSize: 115,
                      height: 0,
                      fontWeight: FontWeight.normal,
                      color: config.chosenTheme.titleTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 3,
                child: SvgPicture.asset(
                  "assets/images/auth.svg",
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Text(
                "Please fill the following details before continuing:",
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: MediaQuery.of(context).size.height / 65,
                  color: const Color.fromRGBO(123, 124, 125, 1),
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              SizedBox(
                height: size.height / 12,
                child: TextField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
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
                    hintText: "First Name",
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
                height: size.height / 100,
              ),
              SizedBox(
                height: size.height / 12,
                child: TextField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
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
                    hintText: "Last Name (Optional)",
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
                height: size.height / 100,
              ),
              SizedBox(
                height: size.height / 12,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                    hintText: "Email (Optional)",
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
                    if (_firstNameController.text.trim() == "") {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Error",
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content:
                              const Text("Please enter your name to continue."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
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
                    await FirebaseAuth.instance.currentUser!.updateDisplayName(
                      getGoodName(
                        _firstNameController.text.trim(),
                        _lastNameController.text.trim(),
                      ),
                    );
                    await UserModel(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      email: _emailController.text.trim(),
                    ).add();
                    Navigator.pop(config.navigatorKey.currentContext!);
                    config.navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      "/home",
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontFamily: "SF Pro Display",
                      fontWeight: FontWeight.bold,
                      fontSize: size.height / 40,
                      height: -0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               const Text(
  //                 "Farm",
  //                 style: TextStyle(
  //                     fontFamily: "SF Pro Display",
  //                     fontSize: 50,
  //                     fontWeight: FontWeight.w900),
  //               ),
  //               Text(
  //                 "Xpert",
  //                 style: TextStyle(
  //                     fontFamily: "SF Pro Display",
  //                     fontSize: 50,
  //                     fontWeight: FontWeight.w900,
  //                     color: config.chosenTheme.primaryColor),
  //               ),
  //             ],
  //           ),
  //           const Text(
  //             "Login",
  //             style: TextStyle(
  //                 fontFamily: "SF Pro Display",
  //                 fontSize: 40,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.1,
  //           ),
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width * 0.8,
  //             child: TextField(
  //               controller: _nameController,
  //               decoration: const InputDecoration(
  //                 filled: true,
  //                 hintText: "Name",
  //                 hintStyle: TextStyle(
  //                   fontFamily: "SF Pro Display",
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.02,
  //           ),
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width * 0.8,
  //             child: TextField(
  //               controller: _emailController,
  //               decoration: const InputDecoration(
  //                 filled: true,
  //                 hintText: "Email (Optional)",
  //                 hintStyle: TextStyle(
  //                   fontFamily: "SF Pro Display",
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.03,
  //           ),
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width * 0.8,
  //             child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: config.chosenTheme.secondaryColor,
  //                 foregroundColor: Colors.white,
  //                 padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
  //               ),
  //               onPressed: () {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // if (_nameController.text.isNotEmpty) {
  //   _auth.currentUser!
  //       .updateDisplayName(_nameController.text.trim());
  // } else {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text(
  //         "Error",
  //         style: TextStyle(
  //           fontFamily: "SF Pro Display",
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       content:
  //           const Text("Please enter your name to continue."),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text("OK"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // if (_emailController.text.isNotEmpty) {
  //   _auth.currentUser!
  //       .updateEmail(_emailController.text.trim());
  // }
  // config.navigatorKey.currentState!.pushNamedAndRemoveUntil(
  //   "/home",
  //   (route) => false,
  // );
  //               },
  //               child: const Text(
  //                 "Login",
  //                 style: TextStyle(
  //                   fontFamily: "SF Pro Display",
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
