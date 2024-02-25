import 'package:FarmXpert/misc/config.dart';
import 'package:FarmXpert/store/terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellerSignupScreen extends StatelessWidget {
  const SellerSignupScreen({
    super.key,
    required this.mainSetState,
  });

  final void Function(void Function()) mainSetState;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top * 2,
        ),
        child: Column(
          children: [
            const Spacer(),
            Text(
              "Become an E-Seller",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.05,
                fontFamily: "SF Pro Display",
                fontWeight: FontWeight.bold,
                color: config.chosenTheme.titleTextColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset("assets/images/splash/3.svg"),
            const Spacer(),
            SizedBox(
              width: size.width / 1.3,
              child: const Text(
                "Sell your products on FarmXPert by clicking the button given below:",
              ),
            ),
            const SizedBox(
              height: 20,
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
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => TermsScreen(
                            mainSetState: mainSetState,
                          )));
                },
                child: Text(
                  "Become E-Seller",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height / 40,
                    height: -0.2,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
