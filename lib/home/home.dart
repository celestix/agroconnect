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
    'Modified Interest Subvention Scheme (MISS)',
    'Market Intervention Scheme and Price support Scheme (MIS-PSS)',
    'Pashu Kisan Credit Card Scheme ',
    'Agri Infrastructure Fund',
    'Soil Health Card Scheme',
    'PM Kisan Sampada Yojana',
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
                  height: MediaQuery.of(context).size.height * 0.25,
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
                              const Text(
                                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim."),
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
