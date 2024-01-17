import 'package:FarmXpert/misc/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Farm",
                  style: TextStyle(
                      fontFamily: "SF Pro Display",
                      fontSize: 50,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Xpert",
                  style: TextStyle(
                      fontFamily: "SF Pro Display",
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: config.chosenTheme.primaryColor),
                ),
              ],
            ),
            const Text(
              "Login",
              style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Name",
                  hintStyle: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Email (Optional)",
                  hintStyle: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: config.chosenTheme.secondaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                ),
                onPressed: () {
                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  if (_nameController.text.isNotEmpty) {
                    _auth.currentUser!
                        .updateDisplayName(_nameController.text.trim());
                  } else {
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
                  }
                  if (_emailController.text.isNotEmpty) {
                    _auth.currentUser!
                        .updateEmail(_emailController.text.trim());
                  }
                  config.navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    "/home",
                    (route) => false,
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
