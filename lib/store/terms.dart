import 'package:AgroConnect/misc/config.dart';
import 'package:AgroConnect/store/seller_profile.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({
    super.key,
    required this.mainSetState,
  });

  final void Function(void Function()) mainSetState;

  Column getSection(String heading, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(description),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: ListView(
          children: [
            const Center(
              child: Text(
                "AgroConnect",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text(
                "E-Seller Terms and Conditions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Welcome to AgroConnect! We're delighted to have you as a potential e-seller on our platform. Before you embark on your journey as a seller, please carefully read and understand the terms and conditions outlined below.\nBy clicking the \"Become E-Seller\" button, you agree to comply with the following terms:",
            ),
            const SizedBox(
              height: 25,
            ),
            getSection(
              "1. Eligibility:",
              "To become an e-seller on AgroConnect, you must be at least 18 years old and capable of entering into a legally binding agreement. You should also possess the legal right to sell the products or services you offer on our platform.",
            ),
            getSection(
              "2. Account Registration:",
              "You will need to create an account on AgroConnect to become an e-seller. Provide accurate and complete information during the registration process. You are responsible for maintaining the confidentiality of your account credentials.",
            ),
            getSection(
              "3. Product Listings:",
              """
        • Ensure that all products or services listed comply with applicable laws and regulations.
        • Provide accurate and detailed information about your products, including prices, specifications, and terms of sale.
        • You are responsible for updating product information to reflect accurate availability and pricing.""",
            ),
            getSection(
              "4. Sales and Transactions:",
              """
        • AgroConnect will facilitate transactions between you and the buyers. You agree to fulfill orders promptly and provide accurate shipping information.
        • Any transaction disputes or customer complaints will be resolved through the AgroConnect dispute resolution process.""",
            ),
            getSection(
              "5. Fees and Payments:",
              """
        • AgroConnect may charge fees for using the platform. Details of these fees will be provided in our fee schedule.
        • Payments from buyers will be processed by AgroConnect, and you will receive payouts according to our payment schedule.""",
            ),
            getSection(
              "6. Prohibited Items:",
              "Do not list or sell prohibited items, including but not limited to illegal products, counterfeit goods, or items that infringe on intellectual property rights.",
            ),
            getSection(
              "7. Compliance with Laws:",
              "You agree to comply with all applicable laws and regulations, including tax laws, when using AgroConnect.",
            ),
            getSection(
              "8. Termination:",
              "AgroConnect reserves the right to terminate your e-seller account at any time for violations of these terms or any other misconduct.",
            ),
            getSection(
              "9. Modification of Terms:",
              "AgroConnect may update or modify these terms from time to time. You will be notified of any changes, and your continued use of the platform constitutes acceptance of the revised terms.",
            ),
            getSection(
              "10. Privacy:",
              "Your privacy is important to us. Refer to our Privacy Policy for information on how we collect, use, and protect your personal data.",
            ),
            const Text(
                "By clicking the \"Become E-Seller\" button, you acknowledge that you have read, understood, and agree to abide by these terms and conditions. If you do not agree with any part of these terms, please do not proceed with becoming an e-seller on AgroConnect."),
            const SizedBox(
              height: 15,
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
                  config.user!.isSeller = true;
                  await config.user!.update();
                  await config.navigatorKey.currentState!
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return SellerProfileScreen(
                      mainSetState: mainSetState,
                    );
                  }));
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
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
