import 'dart:async';

import 'package:AgroConnect/farmbook/farmbook.dart';
import 'package:AgroConnect/home/coming_soon.dart';
import 'package:AgroConnect/misc/config.dart';
import 'package:AgroConnect/store/main_store.dart';
import 'package:AgroConnect/weather/weather_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageTexts = [
    'ChatBot',
    'FarmBook',
    'Community',
    'Marketplace',
  ];

  List<String> textSliderTexts = [
    'Pradhan Mantri Kisan MaanDhan Yojana',
    'Pradhan Mantri Fasal Bima Yojana (PMFBY)',
    'Rastriya Krishi Vikas Yojana',
    'PM Kisan Sampada Yojana',
    'Modified Interest Subvention Scheme (MISS)',
    'Market Intervention Scheme and Price support Scheme (MIS-PSS)',
    'Pashu Kisan Credit Card Scheme ',
    'Agri Infrastructure Fund',
    'Soil Health Card Scheme',
  ];

  List<String> textSliderDescriptions = [
    "The Pradhan Mantri Kisan Maandhan Yojana provides financial security to small and marginal farmers aged 18 to 40. They contribute monthly (₹55 to ₹200) until 60 and receive a guaranteed ₹3000 monthly pension. In case of the farmer's death, the spouse gets 50% as a family pension. The scheme ensures retirement support for farmers.",
    "The Pradhan Mantri Fasal Bima Yojana (PMFBY) started in India in 2016, with the National Insurance Company joining from 2016. Covering 8 states and 2 Union Territories over 5 seasons, 70,27,637 farmers participated, contributing Rs. 453 crores. State subsidies amounted to Rs. 1909 crores, resulting in a total gross premium of Rs. 2362 crores.",
    "Rashtriya Krishi Vikas Yojana (RKVY) - Remunerative Approaches for Agriculture and Allied sector Rejuvenation (RAFTAAR) aims at making farming a remunerative economic activity by strengthening the farmers' efforts, risk mitigation and promoting agri-business entrepreneurship.",
    "PM Kisan Sampada Yojana benefits farmers by providing financial assistance for infrastructure development, processing units, and value addition in agriculture. It enhances farm income, reduces post-harvest losses, and ensures better market access. The scheme fosters employment opportunities and promotes sustainable agriculture.",
    "The Union Cabinet, led by Prime Minister Narendra Modi, has approved restoring the Interest Subvention on short-term agriculture loans to 1.5% for all financial institutions. This support, spanning 2022-23 to 2024-25, involves an additional budget of Rs 34,856 crore. The move aims to sustain credit flow in agriculture, and promote rural employment.",
    "The Market Intervention Scheme (MIS) acts as a price support mechanism for perishable and horticultural commodities, triggered by a 10% production increase or a 10% price decrease. Implemented on State Government requests, it shields growers from distress sales during bumper crops, providing remunerative prices.",
    "The Pashu Kisan Credit Card scheme, launched by the Government of India, aims to benefit animal husbandry farmers by providing working capital for their livestock-related activities. Features include loans up to Rs. 3 lakh with lower interest rates, repayment within five years, and six equal instalments for cattle owners.",
    "The announcement of the 1 lakh crore Agri Infrastructure Fund by the Finance Minister aims to develop farm-gate infrastructure, benefiting farmers and promoting post-harvest management. This scheme targets financing agriculture infrastructure projects at farm-gate and aggregation points, including cooperatives, farmer organizations, and startups.",
    "The Soil Health Card Scheme offers farmers personalized soil health information and recommendations for better crop management. Benefits include optimized fertilizer use, increased crop yield, reduced input costs, and improved soil fertility and sustainability. It enables informed decision-making, enhances productivity.",
  ];

  Map<String, Widget?> homeRoutes = {
    "FarmBook": const FarmbookScreen(),
    "Marketplace": const StoreScreen(),
  };

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late final Timer _timer;

  void _timerCallback(Timer timer) {
    _currentIndex = ((_currentIndex + 1) % textSliderTexts.length);
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), _timerCallback);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "AgroConnect",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 10,
        backgroundColor: config.chosenTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: config.chosenTheme.primaryColorLight,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/farmer.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? "User",
                  style: const TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.phoneNumber!,
                  style: const TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                  ),
                  child: Divider(
                    height: MediaQuery.of(context).size.height / 100,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: ListView(
                    children: [
                      ListTile(
                        title: const Text("Home"),
                        onTap: () => throw Exception("Home Not Implemented"),
                      ),
                      ListTile(
                        title: const Text("Settings"),
                        onTap: () =>
                            throw Exception("Settings Not Implemented"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      config.scaffoldKey.currentState!.showSnackBar(
                        const SnackBar(
                          content: Text("Logged out successfully"),
                        ),
                      );
                      await config.navigatorKey.currentState!
                          .pushNamedAndRemoveUntil(
                        "/splash",
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: config.chosenTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w600,
                        height: -0.2,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                      // height: MediaQuery.of(context).size.height / 30,
                      ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height / 100,
                  thickness: 0.15,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: const Icon(
                        Icons.agriculture,
                        size: 50,
                      ),
                      applicationName: "AgroConnect",
                      applicationVersion: "1.0.0",
                      children: [
                        const Text(
                          "AgroConnect is a mobile application made for the farmers. It is a one stop solution for all the problems faced by the farmers. It is made with the aim to help the farmers in every possible way.",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 100,
                    ),
                    child: const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageNotFound()),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.lightGreen[50],
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: textSliderTexts.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  textSliderTexts[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(textSliderDescriptions[index]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
              child: GridView.builder(
                itemCount: imageTexts.length,
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Colors.lightGreen[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigate to the corresponding page when an image is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                homeRoutes[imageTexts[index]] ??
                                const PageNotFound(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/home/${imageTexts[index]}.png",
                            height: 80,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            imageTexts[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SF Pro Display",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeatherScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: config.chosenTheme.primaryTextColor,
              elevation: 0,
              backgroundColor: config.chosenTheme.primaryColor,
              minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
            ),
            child: const Text(
              "Check Today's Weather",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "SF Pro Display",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
